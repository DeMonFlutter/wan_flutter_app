import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/FirstRefreshLayout.dart';
import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HotProjectPage extends StatefulWidget {
  @override
  createState() => new HotProjectPageState();
}

class HotProjectPageState extends State<HotProjectPage> {
  EasyRefreshController _controller = EasyRefreshController();
  bool firstRefresh = true;
  int page = 0;
  int showWidget = 0;

  List<dynamic> dataList = List();

  mockNetworkData(int page) async {
    this.page = page;
    if (page == 0) {
      dataList.clear();
    }
    HttpUtils.instance.getFuture("article/listproject", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 0 && list.isEmpty) {
        setState(() => showWidget = 1);
      } else {
        setState(() {
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

  _buildList(dynamic data, int index) {
    return CollectListView(
      data,
      ListTile(
          onTap: () {
            Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
          },
          leading: Image.network(data['envelopePic'], width: 40, fit: BoxFit.scaleDown),
          contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
          title: Text(data['title']),
          subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(data['desc'], maxLines: 3, overflow: TextOverflow.ellipsis),
            Text("作者：${data['author']}   时间：${data['niceDate']}", style: TextStyle(color: Colors.grey)),
          ])),
    );
  }

  @override
  void initState() {
    mockNetworkData(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirstRefreshLayout(
      controller: _controller,
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
