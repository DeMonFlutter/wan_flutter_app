import 'package:flutter/material.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class SettingThemePage extends StatefulWidget {
  @override
  createState() => new SettingThemePageState();
}

class SettingThemePageState extends State<SettingThemePage> {

  List<Widget> _buildColors() {
  }

  @override
  Widget build(BuildContext context) {
    return CenterScaffold("设置主题颜色", <Widget>[
      /*GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
        children: _buildColors,
      )*/
    ]);
  }
}
