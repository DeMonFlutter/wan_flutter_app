import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wan_flutter_app/Routes.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';
import 'package:wan_flutter_app/widget/NestedRefresh.dart';

import 'HotDelegate.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HotBlogPage extends StatefulWidget {
  @override
  createState() => new HotBlogPageState();
}

class HotBlogPageState extends State<HotBlogPage> {
  bool firstRefresh = true;
  int page = 0;
  int showWidget = 0;

  List<dynamic> dataList = List();

  Future<List<RepResult>> mockNetworkData(int page) async {
    this.page = page;
    if (page == 0) {
      dataList.clear();
    }
    return Future.wait([HttpUtils.instance.getFuture("article/list", page: page)]).then((datas) {
      List<dynamic> list = datas[0].data['datas'];
      if (page == 0 && list.isEmpty) {
        setState(() => showWidget = 1);
      } else {
        setState(() => dataList.addAll(list));
      }
    }).catchError((onError) {
      if (page == 0) {
        setState(() => showWidget = 2);
      }
    }).whenComplete(() => setState(() => firstRefresh = false));
  }

  _buildList(dynamic data, int index) {
    String author = data['author'];
    if (StringUtils.isEmpty(author)) {
      author = "分享人：${data['shareUser']}";
    } else {
      author = "作者：${author}";
    }
    String chapterName = data['superChapterName'] + "/" + data['chapterName'];
    return Slidable.builder(
      child: ListTile(
          onTap: () {
            Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
          },
          contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
          title: Text(data['title']),
          subtitle: Text(author + "   分类：" + chapterName + "\n时间：" + data['niceDate'], style: TextStyle(color: Colors.grey))),
      actionPane: SlidableScrollActionPane(),
      secondaryActionDelegate: HotDelegate(),
    );
  }

  @override
  void initState() {
    mockNetworkData(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedRefresh(
      firstRefresh: firstRefresh,
      child: ListView.separated(
        itemBuilder: (context, index) => _buildList(dataList[index], index),
        itemCount: dataList.length,
        separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
      ),
      onRefresh: () => mockNetworkData(0),
      onLoad: () => mockNetworkData(++page),
      showWidget: showWidget,
    );
  }
}
