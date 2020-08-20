import 'package:flutter/material.dart';
import 'package:wan_flutter_app/view/home/HomeView.dart';
import 'package:wan_flutter_app/view/project/ProjectView.dart';
import 'package:wan_flutter_app/view/public/PublicView.dart';
import 'package:wan_flutter_app/view/tree/TreeView.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class MainPageView extends StatefulWidget {
  MainPageView({this.controller});

  final PageController controller;

  @override
  createState() => new MainPageViewState();
}

class MainPageViewState extends State<MainPageView> {
  var _pages;

  @override
  void initState() {
    _pages = <Widget>[HomeView(), TreeView(), ProjectView(), PublicView()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(), //禁止滑动
      controller: widget.controller,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index];
      },
      itemCount: _pages.length,
    );
  }
}
