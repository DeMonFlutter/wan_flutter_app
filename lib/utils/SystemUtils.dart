import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}
