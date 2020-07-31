import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';

import '../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:

var routeMode = -1; //路由模式
var themeMode = 0;  //主题模式
class SplashPage extends StatefulWidget {
  @override
  createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  AnimationController _ctrl;
  bool _animEnd = false;

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: Duration(seconds: 2))
      ..forward()
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _animEnd = true;
          });
          goto();
        }
      });
    //提前初始化
    User.getInstance();
    SPUtils.get(Const.ROUTE_MODE, 0, (i) {
      routeMode = i;
    });
    SPUtils.get(Const.THEME_MODE, 0, (i) {
      themeMode = i;
    });
    super.initState();
  }

  goto() {
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      SPUtils.getData(Const.IS_LOGIN, false).then((onValue) {
        if (onValue) {
          Routes.startPage(context, Routes.HOME, isReplace: true);
        } else {
          Routes.startPage(context, Routes.LOGIN, isReplace: true);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemUtils.setTransparentStatusBar();
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: <Widget>[_buildLogo(), _buildAppName(), _buildPower()],
    ));
  }

  Widget _buildLogo() => Positioned(
      top: 100,
      child: ScaleTransition(
        scale: CurvedAnimation(parent: _ctrl, curve: Curves.linear),
        child: Container(
          width: 100,
          height: 100,
          child: Image.asset('res/images/wan.png'),
        ),
      ));

  Widget _buildAppName() => Positioned(
        top: 250,
        child: Container(
            alignment: Alignment.center,
            width: 300,
            height: 100,
            child: DefaultTextStyleTransition(
              child: Text("wanFlutter"),
              overflow: TextOverflow.ellipsis,
              style: TextStyleTween(
                begin: TextStyle(color: Colors.white, fontSize: 10, shadows: [Shadow(offset: Offset(1, 1), color: Colors.blue, blurRadius: 2)]),
                end: TextStyle(color: Colors.blue, fontSize: 40, shadows: [Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 2)]),
              ).animate(_ctrl),
            )),
      );

  Widget _buildPower() => Positioned(
        bottom: 30,
        right: 30,
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _animEnd ? 1.0 : 0.0,
            child: const Text(
              "Power By DeMon.",
              style: TextStyle(color: Colors.grey, shadows: [Shadow(color: Colors.black, blurRadius: 1, offset: Offset(0.3, 0.3))], fontSize: 16),
            )),
      );

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }
}
