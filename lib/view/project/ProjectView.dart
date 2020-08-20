import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_flutter_app/model/ClassModel.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/DialogUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/FirstRefreshLayout.dart';
import 'package:wan_flutter_app/widget/OptionView.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class ProjectView extends StatefulWidget {
  @override
  createState() => new ProjectViewState();
}

class ProjectViewState extends State<ProjectView> {
  EasyRefreshController _controller = EasyRefreshController();
  int page = 1;
  int showWidget = 0;
  bool firstRefresh = true;
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
        setState(() => showWidget = 1);
      } else {
        setState(() {
          showWidget = 0;
          dataList.addAll(list);
          treeModel = ClassModel.fromJson(dataList[0]);
        });
        cid = treeModel.id;
        projectListData(cid, 1);
      }
    }).catchError((onError) {
      firstError = true;
      setState(() => showWidget = 2);
      print('$onError');
    }).whenComplete(() {
      setState(() => firstRefresh = false);
    });
  }

  projectListData(int id, int page) async {
    this.page = page;
    if (page == 1) {
      projectList.clear();
    }
    HttpUtils.instance.getFuture("project/list", param: {'cid': id}, page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (list.isEmpty || list.length == 0) {
        setState(() => showWidget = 1);
      } else {
        setState(() {
          showWidget = 0;
          projectList.addAll(list);
        });
      }
      _controller.finishLoad(noMore: data.pagingData.over);
    }).catchError((onError) {
      setState(() => showWidget = 2);
    });
  }

  @override
  void initState() {
    mockNetworkData();
    super.initState();
  }

  Widget _buildList(dynamic data, int index) {
    return GridTile(
      header: GridTileBar(
        backgroundColor: Colors.blue,
        subtitle: Text(
          data['title'],
          maxLines: 2,
        ),
        trailing: Icon(data['collect'] ? Icons.favorite : Icons.favorite_border),
      ),
      child: OptionView(
        child: Card(
          margin: EdgeInsets.all(0),
        ),
        onPressed: () {},
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
      body: FirstRefreshLayout(
          showWidget: showWidget,
          controller: _controller,
          onRefresh: () async {
            if (firstError) {
              mockNetworkData();
            } else {
              projectListData(cid, 1);
            }
          },
          onLoad: () => projectListData(cid, ++page),
          firstRefresh: firstRefresh,
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
