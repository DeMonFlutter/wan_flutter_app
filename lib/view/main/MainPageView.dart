import 'package:flutter/material.dart';
import 'package:wan_flutter_app/view/home/PageViewHome.dart';
import 'package:wan_flutter_app/view/project/PageViewProject.dart';
import 'package:wan_flutter_app/view/public/PageViewPublic.dart';
import 'package:wan_flutter_app/view/tree/PageViewTree.dart';

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
    _pages = <Widget>[PageViewHome(), PageViewTree(), PageViewProject(), PageViewPublic()];
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
