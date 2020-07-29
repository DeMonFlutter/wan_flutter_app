import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/utils/DialogUtils.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';
import 'package:wan_flutter_app/widget/GradientView.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomeDrawerView extends StatefulWidget {
  @override
  createState() => new HomeDrawerViewState();
}

class HomeDrawerViewState extends State<HomeDrawerView> {
  Widget _buildAvatar() {
    if (!StringUtils.isEmpty(User.getInstance().icon)) {
      return CircleAvatar(radius: 36.0, backgroundImage: FileImage(File(User.getInstance().icon)));
    }
    return CircleAvatar(radius: 30.0, backgroundImage: AssetImage('res/images/D.png'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Drawer(
        elevation: 3,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: theme.primaryColor),
            child: GradientView(
              onPressed: () {
                //TODO
                //SystemUtils.startPage(context, Const.REGISTER);
              },
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Positioned(
                    left: 10,
                    child: _buildAvatar(),
                  ),
                  Positioned(
                    left: 90,
                    child: Text(
                      User.getInstance().nickname,
                      style: TextStyle(fontSize: 24, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 3)]),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 0,
                    bottom: 15,
                    child: Text(
                      StringUtils.isEmpty(User.getInstance().desc) ? "I decide what tide to bring.我的命运，由我做主。" : User.getInstance().desc,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 1)]),
                    ),
                  ),
                  Positioned(right: 10, child: Icon(Icons.arrow_right, color: Colors.white))
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              color: Colors.blue,
            ),
            title: Text('我的收藏'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Colors.orangeAccent,
            ),
            title: Text('应用主题颜色设置'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.router,
              color: Colors.purple,
            ),
            title: Text('页面跳转动画设置'),
            onTap: () {
              SystemUtils.startPage(context, Const.ROUTE);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.android,
              color: Colors.green,
            ),
            title: Text('应用详情'),
            onTap: () {},
          ),
        ]));
  }
}
