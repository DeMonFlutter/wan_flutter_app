import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc: 可点击的渐变View
class GradientView extends StatelessWidget {
  GradientView({this.colors, this.width, this.height, this.onPressed, this.borderRadius, this.child});

  // 渐变色数组
  final Color colors;

  // 按钮宽高
  final double width;
  final double height;

  final double borderRadius;

  final Widget child;

  //点击回调
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    //确保colors数组不空
    List<Color> _colors = colors ?? [theme.primaryColor, theme.primaryColorDark];
    double _borderRadius = borderRadius ?? 5.0;
    return DecoratedBox(
      decoration: BoxDecoration(gradient: LinearGradient(colors: _colors), borderRadius: BorderRadius.circular(_borderRadius)),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          splashColor: _colors.last,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(_borderRadius),
          onTap: onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(height: height, width: width),
            child: child,
          ),
        ),
      ),
    );
  }
}
