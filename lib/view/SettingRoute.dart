import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/style/DIcons.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';

import '../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class SettingRoutePage extends StatefulWidget {
  @override
  createState() => new SettingRoutePageState();
}

final Map<int, RouteInfo> routes = {
  0: RouteInfo("Android(默认)", "使用Andriod系统默认的页面跳转动画", Icons.android),
  -1: RouteInfo("IOS", "使用IOS系统默认页面跳转动画", DIcons.ios),
  1: RouteInfo("左右滑动", "使用平滑的左入右出风格的页面跳转动画", DIcons.left_right),
  2: RouteInfo("上下滑动", "使用平滑的上入下出风格的页面跳转动画", DIcons.up_down),
  3: RouteInfo("渐变过渡", "使用淡入淡出风格的页面跳转动画", Icons.gradient),
  4: RouteInfo("旋转缩放", "使用旋转缩放风格的页面跳转动画", Icons.rotate_90_degrees_ccw),
};

class SettingRoutePageState extends State<SettingRoutePage> {
  @override
  Widget build(BuildContext context) {
    return CenterScaffold(
      "设置页面跳转动画",
      routes.keys
          .map((i) => RadioListTile<int>(
              value: i,
              groupValue: routeMode,
              title: Text(routes[i].title),
              subtitle: Text(routes[i].subTitle),
              selected: routeMode == i,
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: Icon(routes[i].icon),
              onChanged: (i) {
                setState(() {
                  routeMode = i;
                });
                SPUtils.setData(Const.ROUTE_MODE, routeMode);
              }))
          .toList(),
      alignment: Alignment.topCenter,
    );
  }
}

class RouteInfo {
  String title;
  String subTitle;
  IconData icon;

  RouteInfo(this.title, this.subTitle, this.icon);
}
