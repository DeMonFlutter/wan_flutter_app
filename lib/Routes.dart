import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/view/home/Home.dart';
import 'package:wan_flutter_app/view/Login.dart';
import 'package:wan_flutter_app/view/Register.dart';
import 'package:wan_flutter_app/view/Splash.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
class Routes {
  static final routes = {
    "/": (context) => SplashPage(),
    Const.HOME: (context) => HomePage(),
    Const.LOGIN: (context) => LoginPage(),
    Const.REGISTER: (context) => RegisterPage(),
  };
}
