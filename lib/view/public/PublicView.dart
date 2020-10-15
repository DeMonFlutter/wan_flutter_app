import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_flutter_app/model/PublicModel.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/FirstRefreshLayout.dart';

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
  EasyRefreshController _controller = EasyRefreshController();
  List<PublicModel> dataList = List();
  int cid = 408;
  int page = 1;
  int showWidget = 0;
  bool firstRefresh = true;
  bool firstError = false;
  List<dynamic> articleList = List();

  @override
  void initState() {
    dataList.add(PublicModel(name: "鸿洋", id: 408));
    dataList.add(PublicModel(name: "郭霖", id: 409));
    articleListData(1);
    super.initState();
  }

  articleListData(int page) async {
    this.page = page;
    if (page == 1) {
      articleList.clear();
    }
    HttpUtils.instance.getFuture("wxarticle/list/$cid", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (list.isEmpty || list.length == 0) {
        setState(() => showWidget = 1);
      } else {
        setState(() {
          showWidget = 0;
          articleList.addAll(list);
        });
      }
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      setState(() => showWidget = 2);
    }).whenComplete(() => setState(() => firstRefresh = false));
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
              Routes.startPage(context, Routes.PUBLIC_SET);
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
      body: FirstRefreshLayout(
          showWidget: showWidget,
          controller: _controller,
          onRefresh: () async {
            articleListData(1);
          },
          onLoad: () => articleListData(++page),
          firstRefresh: firstRefresh,
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
