import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EditForm.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class RegisterPage extends StatefulWidget {
  @override
  createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  var username, password, repassword;
  FocusNode focusNode1 = FocusNode(); //密码框焦点
  FocusNode focusNode2 = FocusNode(); //密码框焦点
  register(BuildContext context) {
    SystemUtils.hideSoftKeyboard(context);
    if (StringUtils.isEmpty(username)) {
      Fluttertoast.showToast(msg: '用户名不能为空！');
      return;
    }

    if (StringUtils.isEmpty(password)) {
      Fluttertoast.showToast(msg: '密码不能为空！');
      return;
    }

    if (StringUtils.isEmpty(repassword)) {
      Fluttertoast.showToast(msg: '确认密码不能为空！');
      return;
    }

    if (password != repassword) {
      Fluttertoast.showToast(msg: '两次输入密码不一致！');
      return;
    }

    HttpUtils.instance.post(context, "user/register", (result) {
      Fluttertoast.showToast(msg: '注册成功！');
      Navigator.of(context).pop();
    }, data: {"username": username, "password": password, "repassword": repassword});
  }

  @override
  Widget build(BuildContext context) {
    return CenterScaffold("注册", <Widget>[
      Text("注册玩Android账号"),
      Padding(
        padding: EdgeInsets.all(20),
        child: EditForm(
          icon: Icons.account_circle,
          hintText: "请输入用户名",
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(focusNode1);
          },
          onChanged: (str) {
            username = str;
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: EditForm(
          icon: Icons.lock_outline,
          obscureText: true,
          focusNode: focusNode1,
          textInputAction: TextInputAction.next,
          onEditingComplete: () {
            FocusScope.of(context).requestFocus(focusNode2);
          },
          hintText: "请输入密码",
          onChanged: (str) {
            password = str;
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: EditForm(
          icon: Icons.lock_outline,
          obscureText: true,
          focusNode: focusNode2,
          hintText: "请输入确认密码",
          onChanged: (str) {
            repassword = str;
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.all(20),
        child: GradientButton(
          "注册",
          height: 45,
          onPressed: () {
            register(context);
          },
        ),
      )
    ]);
  }
}
