import 'package:flutter/material.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/style/DColors.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EasyTile.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class UserInfoPage extends StatefulWidget {
  @override
  createState() => new UserInfoPageState();
}

class UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return CenterScaffold(
      "用户信息",
      <Widget>[
        Hero(tag: Const.HERO_HEAD, child: ViewUtils.buildAvatar(radius: 45.0)),
        Divider(height: 50, color: Colors.transparent),
        EasyTile("账号", text: User.getInstance().username, icon: Icons.account_box),
        EasyTile("昵称", text: User.getInstance().nickname, icon: Icons.account_circle, onPressed: () {}),
        EasyTile(
          "个性签名",
          text: StringUtils.isEmpty(User.getInstance().desc) ? "I decide what tide to bring.我的命运，由我做主。" : User.getInstance().desc,
          icon: Icons.assignment,
          onPressed: () {},
        ),
      ],
      backgroundColor: DColors.bg,
    );
  }
}
