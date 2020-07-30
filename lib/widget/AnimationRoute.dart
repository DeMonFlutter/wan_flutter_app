import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/28.
/// E-mail 757454343@qq.com
/// Desc:页面跳转自定义动画
class AnimationRoute extends PageRouteBuilder {
  final RouteMode mode;
  final RouteSettings settings;
  final WidgetBuilder builder;

  AnimationRoute({this.builder, this.settings, this.mode = RouteMode.leftRight})
      : super(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 500), //设置动画时长500毫秒
            pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2) {
              return builder(context);
            },
            transitionsBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2, Widget child) {
              switch (mode.index) {
                case 1: //左右滑动
                  return SlideTransition(
                    position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );
                case 2: //上下滑动
                  return SlideTransition(
                    position: Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0)).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
                    child: child,
                  );
                case 3: //渐变过渡
                  return FadeTransition(
                    //渐变过渡 0.0-1.0
                    opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1, //动画样式
                      curve: Curves.fastOutSlowIn, //动画曲线
                    )),
                    child: child,
                  );
                  break;
                case 4: //旋转缩放
                  return RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animation1,
                      curve: Curves.fastOutSlowIn,
                    )),
                    child: ScaleTransition(
                      scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation1, curve: Curves.fastOutSlowIn)),
                      child: child,
                    ),
                  );
                  break;
                default:
                  return child;
                  break;
              }
            });
}

enum RouteMode { none, leftRight, upDown, gradient, zoom }
