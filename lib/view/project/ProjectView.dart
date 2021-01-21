import 'package:flutter/material.dart';
import 'package:wan_flutter_app/model/ClassModel.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/DialogUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/OptionView.dart';
import 'package:wan_flutter_app/widget/RefreshStatusLayout.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class ProjectView extends StatefulWidget {
  @override
  createState() => new ProjectViewState();
}

class ProjectViewState extends State<ProjectView> {
  RefreshController _controller = RefreshController();
  bool firstError = false;
  ClassModel treeModel = ClassModel(name: "", children: List());
  List<dynamic> dataList = List();
  List<dynamic> projectList = List();
  int cid = 0;

  mockNetworkData() async {
    dataList.clear();
    HttpUtils.instance.getFuture("project/tree").then((data) {
      List<dynamic> list = data.data;
      if (list.isEmpty || list.length == 0) {
        _controller.callback(true, size: 0);
      } else {
        dataList.addAll(list);
        treeModel = ClassModel.fromJson(dataList[0]);
        cid = treeModel.id;
        projectListData(cid, 1);
      }
    }).catchError((onError) {
      print('$onError');
      firstError = true;
      _controller.callback(false);
    });
  }

  projectListData(int id, int page) async {
    HttpUtils.instance.getFuture("project/list", param: {'cid': id}, page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 1) {
        projectList.clear();
      }
      setState(() => projectList.addAll(list));
      _controller.callback(true, size: projectList.length);
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      _controller.callback(false);
    });
  }

  @override
  void initState() {
    mockNetworkData();
    super.initState();
  }

  doCollect(dynamic data) {
    String url = data['collect'] ? 'lg/uncollect_originId/' : 'lg/collect/';
    HttpUtils.instance.post(context, url + '${data['id']}', (result) {
      setState(() {
        data['collect'] = !data['collect'];
      });
    });
  }

  Widget _buildList(dynamic data, int index) {
    ThemeData theme = Theme.of(context);
    bool isCollect = data['collect'];
    return GridTile(
      header: GridTileBar(
        backgroundColor: theme.primaryColor,
        subtitle: Text(
          data['title'],
          maxLines: 2,
        ),
        trailing: IconButton(
          icon: Icon(isCollect ? Icons.favorite : Icons.favorite_border, color: isCollect ? Colors.red : Colors.white),
          onPressed: () {
            doCollect(data);
          },
        ),
      ),
      child: OptionView(
        child: Card(
          margin: EdgeInsets.all(0),
          child: Row(
            children: [
              Image.network(data['envelopePic'], width: 45, fit: BoxFit.scaleDown),
              Expanded(
                child: Text(data['desc'], maxLines: 4, overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
        onPressed: () {
          Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
        },
      ),
      footer: GridTileBar(
        subtitle: Text(
          '${data['author']} \n${data['niceShareDate']}',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ViewUtils.buildAvatarLeading(),
        title: Text("项目", textAlign: TextAlign.center),
        actions: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20),
            child: OptionView(
              isTransparent: true,
              child: Text(
                treeModel.name,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                DialogUtils.showListPick(context, dataList, (data) {
                  setState(() {
                    treeModel = ClassModel.fromJson(data);
                  });
                  cid = treeModel.id;
                  projectListData(cid, 1);
                });
              },
            ),
          )
        ],
      ),
      backgroundColor: DColors.bg,
      body: RefreshStatusLayout(
          initPage: PAGE_ONE,
          controller: _controller,
          refreshCallback: (i) async {
            if (firstError) {
              mockNetworkData();
            } else {
              projectListData(cid, i);
            }
          },
          child: GridView.builder(
            itemCount: projectList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) => _buildList(projectList[index], index),
          )),
    );
  }
}
