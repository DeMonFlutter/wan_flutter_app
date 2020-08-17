import 'package:flutter/material.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/view/main/MainBottomBar.dart';
import 'package:wan_flutter_app/view/main/MainDrawer.dart';
import 'package:wan_flutter_app/view/main/MainPageView.dart';

import '../../main.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class MainPage extends StatefulWidget {
  @override
  createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
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
      drawer: MainDrawerView(),
      body: MainPageView(controller: _controller),
      bottomNavigationBar: MainBottomBar(
        currentIndex: pos,
        callback: (i) {
          pos = i;
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
