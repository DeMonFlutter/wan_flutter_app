import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/24.
/// E-mail 757454343@qq.com
/// Desc:
class CenterScaffold extends Scaffold {
  CenterScaffold(String title, List<Widget> childrens)
      : super(
            appBar: (title == null || title.isEmpty) ? null : AppBar(title: Text(title)),
            body: Center(
                child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: childrens,
              ),
            )));
}
