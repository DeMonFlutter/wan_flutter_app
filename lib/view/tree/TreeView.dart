import 'package:flutter/material.dart';
import 'package:wan_flutter_app/model/ClassModel.dart';
import 'package:wan_flutter_app/utils/DialogUtils.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/OptionView.dart';
import 'package:wan_flutter_app/widget/RefreshStatusLayout.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class TreeView extends StatefulWidget {
  @override
  createState() => new TreeViewState();
}

class TreeViewState extends State<TreeView> with SingleTickerProviderStateMixin {
  RefreshController _controller = RefreshController();
  bool firstError = false;
  ClassModel treeModel = ClassModel(name: "", children: List());
  List<dynamic> dataList = List();
  List<dynamic> articleList = List();

  int cid = 0;

  mockNetworkData() async {
    dataList.clear();
    HttpUtils.instance.getFuture("tree").then((data) {
      List<dynamic> list = data.data;
      if (list.isEmpty || list.length == 0) {
        _controller.callback(true, size: 0);
      } else {
        dataList.clear();
        setState(() => dataList.addAll(list));
        treeModel = ClassModel.fromJson(dataList[0]);
        cid = treeModel.children[0].id;
        articleListData(cid, 0);
      }
    }).catchError((onError) {
      _controller.callback(false);
    });
  }

  articleListData(int id, int page) async {
    if (page == 0) {
      articleList.clear();
    }
    HttpUtils.instance.getFuture("article/list", param: {'cid': id}, page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 0) {
        articleList.clear();
      }
      setState(() => articleList.addAll(list));
      _controller.callback(true, size: articleList.length);
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      _controller.callback(false);
    });
  }

  _buildList(dynamic data, int index) {
    String author = data['author'];
    if (StringUtils.isEmpty(author)) {
      author = "分享人：${data['shareUser']}";
    } else {
      author = "作者：$author";
    }
    return CollectListView(
      data,
      ListTile(
          onTap: () {
            Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
          },
          contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
          title: Text(data['title']),
          subtitle: Text("$author   时间：" + data['niceDate'], style: TextStyle(color: Colors.grey))),
    );
  }

  @override
  void initState() {
    mockNetworkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ViewUtils.buildAvatarLeading(),
        title: Text("体系", textAlign: TextAlign.center),
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
                  cid = treeModel.children[0].id;
                  articleListData(cid, 0);
                });
              },
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(46),
          child: DefaultTabController(
            child: TabBar(
              onTap: (index) {
                cid = treeModel.children[index].id;
                _controller.callRefresh();
              },
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              tabs: treeModel.children
                  .map((e) => Tab(
                        text: e.name,
                      ))
                  .toList(),
              isScrollable: true,
            ),
            length: treeModel.children.length,
          ),
        ),
      ),
      body: RefreshStatusLayout(
          controller: _controller,
          refreshCallback: (i) async {
            if (firstError) {
              mockNetworkData();
            } else {
              articleListData(cid, i);
            }
          },
          child: ListView.separated(
            itemBuilder: (context, index) => _buildList(articleList[index], index),
            itemCount: articleList.length,
            separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
          )),
    );
  }
}
