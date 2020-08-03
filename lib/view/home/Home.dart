import 'package:flutter/material.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/view/home/HomeBottomBar.dart';
import 'package:wan_flutter_app/view/home/HomeDrawer.dart';
import 'package:wan_flutter_app/view/home/HomePageView.dart';

import '../../main.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

final iconMap = {"主页": Icons.home, "收藏": Icons.favorite};

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int pos = 0;
  PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: pos);
    eventBus.on<DrawerEvent>().listen((event) {
      _scaffoldKey.currentState.openDrawer();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: HomeDrawerView(),
      body: HomePageView(
          controller: _controller,
          onPageChanged: (i) => setState(() {
                pos = i;
              })),
      bottomNavigationBar: HomeBottomBar(
        currentIndex: pos,
        callback: (i) {
          _controller.animateToPage(i, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.search)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    eventBus.destroy();
    super.dispose();
  }
}
