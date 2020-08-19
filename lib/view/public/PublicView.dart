import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class PublicView extends StatefulWidget {
  @override
  createState() => new PublicViewState();
}

class PublicViewState extends State<PublicView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text("PublicView"),
    );
  }
}
