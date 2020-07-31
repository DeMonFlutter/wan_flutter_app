import 'package:flutter/cupertino.dart';
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

  /// 隐藏软键盘,且会使其他输入框失去焦点
  static hideSoftKeyboard(BuildContext context) {
    FocusNode blankNode = FocusNode(); //空白焦点,不赋值给任何输入框的focusNode
    FocusScope.of(context).requestFocus(blankNode); //指定为空白焦点
  }
}
