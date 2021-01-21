import 'package:flutter/material.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/RefreshStatusLayout.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2021/1/21.
/// E-mail 757454343@qq.com
/// Desc:
class QuestionPage extends StatefulWidget {
  @override
  createState() => new QuestionPageState();
}

class QuestionPageState extends State<QuestionPage> {
  RefreshController _controller = RefreshController();
  var dataList = List<dynamic>();

  initData(int page) async {
    HttpUtils.getInstance().getFuture("wenda/list", page: page).then((data) {
      List<dynamic> list = data.pagingData.datas;
      if (page == 1) {
        dataList.clear();
      }
      setState(() => dataList.addAll(list));
      _controller.callback(true, size: dataList.length);
      _controller.finishLoad(success: true, noMore: data.pagingData.over);
    }).catchError((onError) {
      _controller.callback(false);
    });
  }

  @override
  void initState() {
    initData(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("每日一答")),
      backgroundColor: DColors.bg,
      body: RefreshStatusLayout(
        initPage: PAGE_ONE,
        controller: _controller,
        refreshCallback: (i) => initData(i),
        child: ListView.separated(
          itemBuilder: (context, index) => _buildList(dataList[index], index),
          itemCount: dataList.length,
          separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
        ),
      ),
    );
  }

  Widget _buildList(dynamic data, int index) {
    return ListTile(
        onTap: () {
          Routes.startWebView(context, {'url': data['link'], 'title': data['title']});
        },
        contentPadding: EdgeInsets.only(left: 16, right: 10, top: 5, bottom: 5),
        title: Text(data['title']),
        subtitle: Text("时间：" + data['niceDate'], style: TextStyle(color: Colors.grey)));
  }
}
