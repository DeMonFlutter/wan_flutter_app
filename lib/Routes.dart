import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/view/SettingRoute.dart';
import 'package:wan_flutter_app/view/SettingTheme.dart';
import 'package:wan_flutter_app/view/home/Home.dart';
import 'package:wan_flutter_app/view/Login.dart';
import 'package:wan_flutter_app/view/Register.dart';
import 'package:wan_flutter_app/view/Splash.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
class Routes {
  static const HOME = "Home";
  static const LOGIN = "Login";
  static const REGISTER = "Register";
  static const ROUTE = "Route";
  static const THEME = "Theme";

  static final routes = {
    "/": (context) => SplashPage(),
    HOME: (context) => HomePage(),
    LOGIN: (context) => LoginPage(),
    REGISTER: (context) => RegisterPage(),
    ROUTE: (context) => SettingRoutePage(),
    THEME: (context) => SettingThemePage(),
  };
}
