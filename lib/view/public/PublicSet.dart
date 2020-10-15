import 'package:flutter/material.dart';
import 'package:wan_flutter_app/model/PublicModel.dart';
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
    dataList.add(PublicModel(name: "鸿洋", id: 408));
    dataList.add(PublicModel(name: "郭霖", id: 409));
    super.initState();
    Future.delayed(Duration.zero, () {
      this.initData();
    });
  }

  initData() {
    HttpUtils.getInstance().get(context, "wxarticle/chapters", (result) {
      List<dynamic> datas = result.data;
      setState(() {
        datas.forEach((element) {
          list.add(PublicModel.fromJson(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("选择公众号")),
        body: ListView.separated(
          itemBuilder: (context, index) => _buildList(list[index], index),
          itemCount: list.length,
          separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey)),
        ));
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
        setState(() {
          dataList.add(model);
        });
      },
    );
  }
}
