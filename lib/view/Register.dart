import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EasyEditForm.dart';
import 'package:wan_flutter_app/widget/EasyForm.dart';
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
  register() {
    HttpUtils.instance.post(context, "user/register", (result) {
      Fluttertoast.showToast(msg: '注册成功！');
      Navigator.of(context).pop();
    }, data: {"username": username, "password": password, "repassword": repassword});
  }

  @override
  Widget build(BuildContext context) {
    return CenterScaffold("注册", <Widget>[
      Text("注册玩Android账号"),
      EasyForm(
        children: <Widget>[
          EasyEditForm(
            icon: Icons.account_circle,
            hintText: "请输入用户名",
            editMode: EditMode.clear,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(focusNode1);
            },
            onChanged: (str) {
              username = str;
            },
            validator: (v) {
              return StringUtils.isEmpty(v) ? '用户名不能为空！' : null;
            },
          ),
          EasyEditForm(
            icon: Icons.lock_outline,
            editMode: EditMode.password,
            focusNode: focusNode1,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(focusNode2);
            },
            hintText: "请输入密码",
            onChanged: (str) {
              password = str;
            },
            validator: (v) {
              return StringUtils.isEmpty(v) ? '密码不能为空！' : null;
            },
          ),
          EasyEditForm(
            editMode: EditMode.password,
            icon: Icons.lock_outline,
            focusNode: focusNode2,
            hintText: "请输入确认密码",
            onChanged: (str) {
              repassword = str;
            },
            validator: (v) {
              return repassword != password ? '两次输入密码不一致！' : null;
            },
          )
        ],
        callback: () => register(),
        buttonText: "注册",
      )
    ]);
  }
}
