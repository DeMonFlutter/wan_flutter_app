import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CollectListView.dart';
import 'package:wan_flutter_app/widget/RefreshStatusLayout.dart';
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
  RefreshController _controller = RefreshController();

  List<dynamic> dataList = List();

  mockNetworkData(int page) async {
    HttpUtils.instance.getFuture("article/listproject", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 0) {
        dataList.clear();
      }
      setState(() => dataList.addAll(list));
      _controller.callback(true, size: dataList.length);
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      _controller.callback(false);
    });
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
    return RefreshStatusLayout(
      controller: _controller,
      refreshCallback: (i) => mockNetworkData(i),
      child: ListView.separated(
        itemBuilder: (context, index) => _buildList(dataList[index], index),
        itemCount: dataList.length,
        separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
      ),
    );
  }
}
