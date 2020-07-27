import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomeDrawerView extends StatefulWidget {
  @override
  createState() => new HomeDrawerViewState();
}

class HomeDrawerViewState extends State<HomeDrawerView> {
  Widget _buildHeader(BuildContext context) {
    ThemeData theme = Theme.of(context);
    DrawerHeader(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.primaryColor),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: _buildAvatar(),
          )
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    FutureBuilder<String>(
        future: SPUtils.getData(Const.USER_AVATAR, ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!StringUtils.isEmpty(snapshot.data)) {
              return Image.file(File(snapshot.data), width: 80, height: 80);
            }
          }
          return Image.asset('res/images/D.png', width: 80, height: 80);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(elevation: 3, child: ListView(children: <Widget>[_buildHeader(context)]));
  }
}
