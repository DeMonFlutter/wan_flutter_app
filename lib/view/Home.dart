import 'package:flutter/material.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';

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
    return CenterScaffold("主页", []);
  }
}
