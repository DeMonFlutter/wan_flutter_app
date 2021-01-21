import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter_app/view/SettingRoute.dart';
import 'package:wan_flutter_app/view/SettingTheme.dart';
import 'package:wan_flutter_app/view/WebView.dart';
import 'package:wan_flutter_app/view/collect/Collect.dart';
import 'package:wan_flutter_app/view/info/EditInfo.dart';
import 'package:wan_flutter_app/view/info/UserInfo.dart';
import 'package:wan_flutter_app/view/Login.dart';
import 'package:wan_flutter_app/view/Register.dart';
import 'package:wan_flutter_app/view/Splash.dart';
import 'package:wan_flutter_app/view/main/Main.dart';
import 'package:wan_flutter_app/view/public/PublicSet.dart';
import 'package:wan_flutter_app/view/question/Question.dart';
import 'package:wan_flutter_app/widget/AnimationRoute.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
var routeMode = -1; //路由模式

class Routes {
  static const HOME = "Home";
  static const LOGIN = "Login";
  static const REGISTER = "Register";
  static const ROUTE = "Route";
  static const THEME = "Theme";
  static const USER_INFO = "User_Info";
  static const EDIT_INFO = "Edit_Info";
  static const WEBVIEW = "WebView";
  static const PUBLIC_SET = "Public_Set";
  static const COLLECT = "Collect";
  static const QUESTION = "Question";
  static final routes = {
    "/": (context) => SplashPage(),
    HOME: (context) => MainPage(),
    LOGIN: (context) => LoginPage(),
    REGISTER: (context) => RegisterPage(),
    ROUTE: (context) => SettingRoutePage(),
    THEME: (context) => SettingThemePage(),
    USER_INFO: (context) => UserInfoPage(),
    EDIT_INFO: (context) => EditInfoPage(),
    WEBVIEW: (context) => WebViewPage(),
    PUBLIC_SET: (context) => PublicSetPage(),
    COLLECT: (context) => CollectPage(),
    QUESTION: (context) => QuestionPage(),
  };

  /// 封装过渡动画的路由跳转
  static Future startPage(BuildContext context, String routeName, {Object arguments, bool isReplace = false}) {
    //系统默认：MaterialPageRoute无效果
    if (routeMode == 0) {
      if (isReplace) {
        return Navigator.of(context).pushReplacementNamed(routeName, arguments: arguments);
      } else {
        return Navigator.of(context).pushNamed(routeName, arguments: arguments);
      }
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
    return Navigator.of(context).push(pageRoute);
  }

  static Future startWebView(BuildContext context, Object arguments) {
    return startPage(context, WEBVIEW, arguments: arguments);
  }
}
