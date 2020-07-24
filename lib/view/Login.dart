import 'package:flutter/material.dart';
import 'package:wan_flutter_app/style/DIcons.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EditForm.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return CenterScaffold(null, <Widget>[
      Container(
        width: 100,
        height: 100,
        child: Image.asset('res/images/wan.png'),
        margin: EdgeInsets.all(20),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: EditForm(
          icon: Icons.account_circle,
          hintText: "请输入您的用户名",
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: EditForm(
          icon: Icons.lock_outline,
          obscureText: true,
          hintText: "请输入您的密码",
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: GradientButton(
          "登录",
          height: 45,
        ),
      )
    ]);
  }
}
