import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/PublicModel.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';

/// @author DeMon
/// Created on 2020/10/15.
/// E-mail 757454343@qq.com
/// Desc:
class PublicSetPage extends StatefulWidget {
  @override
  createState() => new PublicSetPageState();
}

class PublicSetPageState extends State<PublicSetPage> {
  List<PublicModel> list = List();
  final _biggerFont = const TextStyle(fontSize: 16.0);
  List<PublicModel> dataList = List();

  @override
  void initState() {
    //初始默认的数据
    dataList.add(PublicModel(name: "鸿洋", id: 408));
    dataList.add(PublicModel(name: "郭霖", id: 409));
    SPUtils.get(Const.PUBLIC_LIST, json.encode(dataList), (result) {
      dataList.clear();
      List list = json.decode(result);
      list.forEach((element) {
        dataList.add(PublicModel(name: element["name"], id: element["id"]));
      });
      this.initData();
    });
    super.initState();
  }

  initData() async {
    HttpUtils.getInstance().getFuture("wxarticle/chapters").then((result) {
      list.clear();
      result.data.forEach((element) {
        list.add(PublicModel.fromJson(element));
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("选择公众号")),
        body: RefreshIndicator(
            onRefresh: () => this.initData(),
            child: ListView.separated(
              itemBuilder: (context, index) => _buildList(list[index], index),
              itemCount: list.length,
              separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
            )));
  }

  Widget _buildList(PublicModel model, int index) {
    bool alreadySaved = false;
    dataList.forEach((element) {
      if (element.id == model.id) {
        alreadySaved = true;
      }
    });
    return ListTile(
      title: Text(model.name, style: _biggerFont),
      trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border, color: alreadySaved ? Colors.red : null),
      onTap: () {
        if (this.isContain(model)) {
          if (dataList.length <= 1) {
            Fluttertoast.showToast(msg: '最少需要选择一个公众号！');
            return;
          }
          dataList.removeWhere((element) => element.id == model.id);
        } else {
          dataList.add(model);
        }
        SPUtils.setData(Const.PUBLIC_LIST, json.encode(dataList)).then((bool) {
          setState(() {});
        });
      },
    );
  }

  isContain(PublicModel model) {
    var data;
    try {
      data = dataList.firstWhere((element) => model.id == element.id);
    } catch (e) {}
    return data != null;
  }
}
