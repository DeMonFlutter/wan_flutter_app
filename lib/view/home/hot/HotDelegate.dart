import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// @author DeMon
/// Created on 2020/8/17.
/// E-mail 757454343@qq.com
/// Desc: 
class HotDelegate extends SlideActionDelegate {
  @override
  int get actionCount => 1;

  @override
  Widget build(BuildContext context, int index, Animation<double> animation, SlidableRenderingMode step) {
    return IconSlideAction(
      caption: '收藏',
      color: Colors.red,
      icon: Icons.collections_bookmark,
    );
  }
}
