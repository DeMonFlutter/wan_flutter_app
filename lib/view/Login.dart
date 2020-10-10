import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wan_flutter_app/Routes.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EasyEditForm.dart';
import 'package:wan_flutter_app/widget/EasyForm.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class LoginPage extends StatefulWidget {
  @override
  createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  String username, password;
  FocusNode focusNode = FocusNode(); //密码框焦点

  login() {
    HttpUtils.instance.post(context, "user/login", (result) {
      Fluttertoast.showToast(msg: '登录成功！');
      SPUtils.setData(Const.IS_LOGIN, true);
      User.getInstance().setUser(result.data);
      Routes.startPage(context, Routes.HOME, isReplace: true);
    }, data: {"username": username, "password": password}, isJson: false);
  }

  @override
  Widget build(BuildContext context) {
    return CenterScaffold(null, <Widget>[
      Container(
        width: 100,
        height: 100,
        child: Image.asset('res/images/wan.png'),
        margin: EdgeInsets.all(20),
      ),
      Text("使用玩Android账号登录"),
      EasyForm(
        children: <Widget>[
          EasyEditForm(
              icon: Icons.account_circle,
              hintText: "请输入您的用户名",
              labelText: "用户名",
              helperText: "用户名不区分大小写~",
              editMode: EditMode.clear,
              textInputAction: TextInputAction.next,
              onEditingComplete: () {
                FocusScope.of(context).requestFocus(focusNode);
              },
              onChanged: (value) {
                username = value;
              },
              validator: (v) {
                return StringUtils.isEmpty(v) ? "用户名不能为空！" : null;
              }),
          EasyEditForm(
            icon: Icons.lock_outline,
            labelText: "密码",
            editMode: EditMode.password,
            focusNode: focusNode,
            validator: (v) {
              return StringUtils.isEmpty(v) ? "密码不能为空！" : null;
            },
            hintText: "请输入您的密码",
            onChanged: (value) {
              password = value;
            },
          )
        ],
        buttonText: "登录",
        callback: () => login(),
      ),
      GestureDetector(
        child: Text("没有账号？注册", style: TextStyle(color: Colors.blue)),
        onTap: () {
          Routes.startPage(context, Routes.REGISTER);
        },
      )
    ]);
  }
}
