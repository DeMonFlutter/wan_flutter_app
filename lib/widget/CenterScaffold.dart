import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc: 默认垂直排列，居中显示的Scaffold
class CenterScaffold extends Scaffold {
  CenterScaffold(String title, List<Widget> childrens, {Color backgroundColor = Colors.white, AlignmentGeometry alignment = Alignment.center})
      : super(
          appBar: (title == null || title.isEmpty) ? null : AppBar(title: Text(title)),
          body: Container(
            alignment: alignment,
            child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: childrens)),
          ),
          backgroundColor: backgroundColor,
        );
}
