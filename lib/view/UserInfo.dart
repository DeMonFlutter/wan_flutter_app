import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/UserModel.dart';
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
    UserModel userModel = Provider.of<UserModel>(context);
    return CenterScaffold(
      "用户信息",
      <Widget>[
        Hero(tag: Const.HERO_HEAD, child: ViewUtils.buildAvatar(radius: 45.0)),
        Divider(height: 50, color: Colors.transparent),
        EasyTile("账号", text: userModel.user.username, icon: Icons.account_box),
        EasyTile("昵称", text: userModel.user.nickname, icon: Icons.account_circle, onPressed: () {}),
        EasyTile("邮箱", text: userModel.user.email, icon: Icons.email, onPressed: () {
          userModel.user.setInfo(desc: "我的命运，由我做主。");
          userModel.changeUser();
        }),
        EasyTile(
          "个性签名",
          text: StringUtils.isEmpty(userModel.user.desc) ? "I decide what tide to bring.我的命运，由我做主。" : userModel.user.desc,
          icon: Icons.assignment,
          onPressed: () {},
        ),
      ],
      backgroundColor: DColors.bg,
    );
  }
}
