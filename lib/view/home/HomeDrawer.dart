
import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/widget/GradientView.dart';

import '../../Routes.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomeDrawerView extends StatefulWidget {
  @override
  createState() => new HomeDrawerViewState();
}

class HomeDrawerViewState extends State<HomeDrawerView> {
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
                SystemUtils.startPage(context, Routes.USER_INFO);
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
            onTap: () {
              SystemUtils.startPage(context, Routes.THEME);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.router,
              color: Colors.purple,
            ),
            title: Text('页面跳转动画设置'),
            onTap: () {
              SystemUtils.startPage(context, Routes.ROUTE);
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
