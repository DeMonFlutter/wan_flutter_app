import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/FirstRefreshLayout.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2021/1/21.
/// E-mail 757454343@qq.com
/// Desc:
class CollectPage extends StatefulWidget {
  @override
  createState() => new CollectPageState();
}

class CollectPageState extends State<CollectPage> {
  EasyRefreshController _controller = EasyRefreshController();
  var dataList = List<dynamic>();
  int showWidget = 0;
  bool firstRefresh = true;
  int page = 0;

  initData(int page) async {
    this.page = page;
    if (page == 0) {
      dataList.clear();
    }
    HttpUtils.getInstance().getFuture("lg/collect/list", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 0 && list.isEmpty) {
        setState(() => showWidget = 1);
      } else {
        setState(() {
          showWidget = 0;
          dataList.addAll(list);
        });
      }
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      if (page == 0) {
        setState(() => showWidget = 2);
      }
    }).whenComplete(() => setState(() => firstRefresh = false));
  }

  @override
  void initState() {
    initData(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的收藏")),
      backgroundColor: DColors.bg,
      body: FirstRefreshLayout(
        controller: _controller,
        onRefresh: () => initData(0),
        onLoad: () => initData(++page),
        firstRefresh: firstRefresh,
        showWidget: showWidget,
        child: ListView.separated(
          itemBuilder: (context, index) => _buildList(dataList[index], index),
          itemCount: dataList.length,
          separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _buildList(dynamic data, int index) {
    return CollectListView(
      data,
      ListTile(
          onTap: () {
            Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
          },
          contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
          title: Text(data['title']),
          subtitle: Text("时间：" + data['niceDate'], style: TextStyle(color: Colors.grey))),
      isCollectPage: true,
    );
  }
}
