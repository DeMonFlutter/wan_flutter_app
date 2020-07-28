import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wan_flutter_app/Routes.dart';
import 'package:wan_flutter_app/view/Splash.dart';
import 'package:wan_flutter_app/widget/AnimationRoute.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
class SystemUtils {
  static setTransparentStatusBar() {
    setStatusBar(Colors.transparent);
  }

  static setStatusBar(Color color) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: color);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

  /**
   * 隐藏软键盘,且会使其他输入框失去焦点
   */
  static hideSoftKeyboard(BuildContext context) {
    FocusNode blankNode = FocusNode(); //空白焦点,不赋值给任何输入框的focusNode
    FocusScope.of(context).requestFocus(blankNode); //指定为空白焦点
  }

  /**
   * 封装过渡动画的路由跳转
   */
  static startPage(BuildContext context, String routeName, {Object arguments, bool isReplace = false}) {
    print("startPage：$routeName $routeMode");
    //系统默认：MaterialPageRoute无效果
    if (routeMode == 0) {
      if (isReplace) {
        Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
      } else {
        Navigator.of(context).pushNamed(routeName, arguments: arguments);
      }
      return;
    }
    var pageRoute;
    //App内默认效果，CupertinoPageRoute ios风格过渡动画，具有左右滑动效果
    if (routeMode == -1) {
      pageRoute = CupertinoPageRoute(builder: Routes.routes[routeName], settings: RouteSettings(arguments: arguments, name: routeName));
    } else {
      pageRoute = AnimationRoute(
          builder: Routes.routes[routeName],
          mode: RouteMode.values[routeMode],
          settings: RouteSettings(
            arguments: arguments,
            name: routeName,
          ));
    }
    if (isReplace) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(pageRoute);
  }
}
