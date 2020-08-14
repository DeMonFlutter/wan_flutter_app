import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';
import 'package:wan_flutter_app/widget/NestedRefresh.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HotProjectPage extends StatefulWidget {
  @override
  createState() => new HotProjectPageState();
}

class HotProjectPageState extends State<HotProjectPage> {
  bool firstRefresh = true;
  int page = 0;
  int showWidget = 0;

  List<dynamic> dataList = List();

  Future<List<RepResult>> mockNetworkData(int page) async {
    this.page = page;
    if (page == 0) {
      dataList.clear();
    }
    return Future.wait([HttpUtils.instance.getFuture("article/listproject", page: page)]).then((datas) {
      List<dynamic> list = datas[0].data['datas'];
      if (page == 0 && list.isEmpty) {
        setState(() => showWidget = 1);
      } else {
        setState(() {
          dataList.addAll(list);
        });
      }
    }).catchError((onError) {
      if (page == 0) {
        setState(() => showWidget = 2);
      }
    }).whenComplete(() => setState(() => firstRefresh = false));
  }

  _buildList(dynamic data, int index) {
    return ListTile(
      title: Text('$index'),
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
      child: ListView.builder(
        itemBuilder: (context, index) => _buildList(dataList[index], index),
        itemCount: dataList.length,
      ),
      onRefresh: () => mockNetworkData(0),
      onLoad: () => mockNetworkData(page++),
      showWidget: showWidget,
    );
  }
}
