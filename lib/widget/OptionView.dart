import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/30.
/// E-mail 757454343@qq.com
/// Desc: 具有点击效果的View
class OptionView extends StatelessWidget {
  OptionView({this.background, this.onPressed, this.child, this.isTransparent = false});

  final Color background;
  final VoidCallback onPressed;
  final Widget child;
  final bool isTransparent;

  @override
  Widget build(BuildContext context) {
    Color bg;
    if (isTransparent) {
      bg = Colors.transparent;
    } else {
      bg = background ?? Colors.white;
    }
    return Material(
      type: MaterialType.transparency,
      color: bg,
      child: InkWell(onTap: onPressed, child: child),
    );
  }
}
