import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/model/UserModel.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/style/DIcons.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/widget/GradientView.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class MainDrawerView extends StatefulWidget {
  @override
  createState() => new MainDrawerViewState();
}

class MainDrawerViewState extends State<MainDrawerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    UserModel userModel = Provider.of<UserModel>(context);
    User user = userModel.user;
    return Drawer(
        elevation: 3,
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: theme.primaryColor),
            child: GradientView(
              onPressed: () {
                Routes.startPage(context, Routes.USER_INFO);
              },
              child: Stack(
                alignment: Alignment.center, //指定未定位或部分定位widget的对齐方式
                children: <Widget>[
                  Positioned(
                    left: 10,
                    child: Hero(tag: Const.HERO_HEAD, child: ViewUtils.buildAvatar()),
                  ),
                  Positioned(
                    left: 90,
                    child: Text(
                      user.nickname,
                      style: TextStyle(fontSize: 24, color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 3)]),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 0,
                    bottom: 15,
                    child: Text(
                      user.getDesc(),
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
            onTap: () {
              Routes.startPage(context, Routes.COLLECT);
            },
          ),
          ListTile(
            leading: Icon(
              DIcons.question,
              color: DColors.color_1f5b89,
            ),
            title: Text('每日一问'),
            onTap: () {
              Routes.startPage(context, Routes.QUESTION);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Colors.orangeAccent,
            ),
            title: Text('应用主题颜色设置'),
            onTap: () {
              Routes.startPage(context, Routes.THEME);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.router,
              color: Colors.purple,
            ),
            title: Text('页面跳转动画设置'),
            onTap: () {
              Routes.startPage(context, Routes.ROUTE);
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
