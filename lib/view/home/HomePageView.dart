import 'package:flutter/material.dart';

import 'PageViewCollect.dart';
import 'PageViewHome.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomePageView extends StatefulWidget {
  HomePageView({this.controller});

  final PageController controller;

  @override
  createState() => new HomePageViewState();
}

class HomePageViewState extends State<HomePageView> {
  var _pages;

  @override
  void initState() {
    _pages = <Widget>[
      PageViewHome(),
      PageViewCollect()
    ];
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
