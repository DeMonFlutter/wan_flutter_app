import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';

/// @author DeMon
/// Created on 2020/5/6.
/// E-mail 757454343@qq.com
/// Desc:
var themeMode = 0;  //主题模式
class ColorModel extends ChangeNotifier {
  static Map<int, List<Color>> themeColors = {
    0: [Colors.blue, Colors.blue[700], Colors.blueAccent], //默认蓝
    1: [Colors.green, Colors.green[700], Colors.greenAccent], //健康绿
    2: [Colors.lightBlue, Colors.lightBlue[700], Colors.lightBlueAccent], //天空蓝
    3: [Colors.pink, Colors.pink[700], Colors.pinkAccent], //少女粉
    4: [Colors.red, Colors.red[700], Colors.redAccent], //中国红
    5: [Colors.orange, Colors.orange[700], Colors.orangeAccent], //幸运橙
    6: [Colors.deepOrange, Colors.orange[700], Colors.deepOrangeAccent], //温暖橙
    7: [Colors.purple, Colors.purple[700], Colors.purpleAccent], //魅力紫
    8: [Colors.deepPurple, Colors.deepPurple[700], Colors.deepPurpleAccent], //诱惑紫
    9: [Colors.indigo, Colors.indigo[700], Colors.indigoAccent], //蓝靛青
    10: [Colors.cyan, Colors.cyan[700], Colors.cyanAccent], //清新青
    11: [Colors.teal, Colors.teal[700], Colors.tealAccent], //茶叶绿
    12: [Colors.amber, Colors.amber[700], Colors.amberAccent], //琥珀黄
    13: [Colors.yellow, Colors.yellow[700], Colors.yellowAccent], //活力黄
  };

  Color themeColor; //当前路由主题色
  Color themeColorDark; //当前路由主题色的深色
  Color accentColor;

  change() {
    SPUtils.get(Const.THEME_MODE, 0, (i) {
      themeColor = themeColors[i][0];
      themeColorDark = themeColors[i][1];
      accentColor = themeColors[i][2];
      themeMode = i;
      notifyListeners();
    });
  }
}
