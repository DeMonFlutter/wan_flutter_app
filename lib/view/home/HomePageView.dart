import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/utils/CallBack.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';

import 'PageViewCollect.dart';
import 'PageViewHome.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomePageView extends StatefulWidget {
  HomePageView({this.controller,this.onPageChanged});

  final PageController controller;
  final TCallback onPageChanged;

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
      controller: widget.controller,
      onPageChanged: (i) {
        widget.onPageChanged(i);
      },
      itemBuilder: (BuildContext context, int index) {
        return _pages[index];
      },
      itemCount: _pages.length,
    );
  }
}
