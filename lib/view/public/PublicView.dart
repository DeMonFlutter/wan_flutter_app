import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/PublicModel.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/RefreshStatusLayout.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class PublicView extends StatefulWidget {
  @override
  createState() => new PublicViewState();
}

class PublicViewState extends State<PublicView> {
  RefreshController _controller = RefreshController();
  List<PublicModel> dataList = List();
  int cid = 408;
  List<dynamic> articleList = List();

  @override
  void initState() {
    //初始默认的数据
    dataList.add(PublicModel(name: "鸿洋", id: 408));
    dataList.add(PublicModel(name: "郭霖", id: 409));
    this.initData();
    super.initState();
  }

  initData() {
    SPUtils.get(Const.PUBLIC_LIST, json.encode(dataList), (result) {
      print(result);
      dataList.clear();
      List list = json.decode(result);
      list.forEach((element) {
        dataList.add(PublicModel(name: element["name"], id: element["id"]));
      });
      setState(() {

      });
      cid = dataList[0].id;
      articleListData(1);
    });
  }

  articleListData(int page) async {
    HttpUtils.instance.getFuture("wxarticle/list/$cid", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 1) {
        articleList.clear();
      }
      setState(() => articleList.addAll(list));
      _controller.callback(true, size: articleList.length);
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      _controller.callback(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ViewUtils.buildAvatarLeading(),
        title: Text("公众号", textAlign: TextAlign.center),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Routes.startPage(context, Routes.PUBLIC_SET).then((value) {
                print(value);
                this.initData();
              });
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(46),
          child: DefaultTabController(
            child: TabBar(
              onTap: (index) {
                cid = dataList[index].id;
                _controller.callRefresh();
              },
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.white,
              tabs: dataList.map((e) => Tab(text: e.name)).toList(),
              isScrollable: true,
            ),
            length: dataList.length,
          ),
        ),
      ),
      backgroundColor: DColors.bg,
      body: RefreshStatusLayout(
          initPage: PAGE_ONE,
          controller: _controller,
          refreshCallback: (i) => articleListData(i),
          child: ListView.separated(
            itemBuilder: (context, index) => _buildList(articleList[index], index),
            itemCount: articleList.length,
            separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
          )),
    );
  }

  _buildList(dynamic data, int index) {
    return CollectListView(
      data,
      ListTile(
          onTap: () {
            Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
          },
          contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
          title: Text(data['title']),
          subtitle: Text("时间：" + data['niceDate'], style: TextStyle(color: Colors.grey))),
    );
  }
}
