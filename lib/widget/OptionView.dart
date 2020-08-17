import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/30.
/// E-mail 757454343@qq.com
/// Desc: 具有点击效果的View
class OptionView extends StatelessWidget {
  OptionView({this.background, this.onPressed, this.child});

  final Color background;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? Colors.white,
      child: InkWell(onTap: onPressed, child: child),
    );
  }
}
