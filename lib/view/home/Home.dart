import 'package:flutter/material.dart';
import 'package:wan_flutter_app/view/home/HomeBottomBar.dart';
import 'package:wan_flutter_app/view/home/HomeDrawer.dart';
import 'package:wan_flutter_app/view/home/HomePageView.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomePage extends StatefulWidget {
  @override
  createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: HomePageView(),
      drawer: HomeDrawerView(),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.search)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomeBottomBar(callback: (i) {}),
    );
  }
}
