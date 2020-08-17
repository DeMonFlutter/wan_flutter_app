import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter_app/Routes.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/UserModel.dart';
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

const EDIT_NAME = 0;
const EDIT_EMAIL = 1;
const EDIT_DESC = 2;

class UserInfoPageState extends State<UserInfoPage> {
  var what = -1;
  var content = "";
  UserModel userModel;
  editInfo() {
    Routes.startPage(context, Routes.EDIT_INFO, arguments: {'what': what, 'content': content}).then((onValue){
      userModel.changeUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    userModel = Provider.of<UserModel>(context);
    return CenterScaffold(
      "用户信息",
      <Widget>[
        Hero(tag: Const.HERO_HEAD, child: ViewUtils.buildAvatar(radius: 45.0)),
        Divider(height: 50, color: Colors.transparent),
        EasyTile("账号", text: userModel.user.username, icon: Icons.account_box),
        EasyTile("昵称", text: userModel.user.nickname, icon: Icons.account_circle, onPressed: () {
          what = EDIT_NAME;
          content = userModel.user.nickname;
          editInfo();
        }),
        EasyTile("邮箱", text: userModel.user.email, icon: Icons.email, onPressed: () {
          what = EDIT_EMAIL;
          content = userModel.user.email;
          editInfo();
        }),
        EasyTile(
          "个性签名",
          text: userModel.user.getDesc(),
          icon: Icons.assignment,
          onPressed: () {
            what = EDIT_DESC;
            content = userModel.user.getDesc();
            editInfo();
          },
        ),
      ],
    );
  }
}
