import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EasyEditForm.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class EditInfoPage extends StatefulWidget {
  @override
  createState() => new EditInfoPageState();
}

class EditInfoPageState extends State<EditInfoPage> {
  @override
  Widget build(BuildContext context) {
    ModalRoute.of(context).settings.arguments;
    return CenterScaffold(
      "编辑",
      <Widget>[
        Padding(padding: EdgeInsets.all(20), child: EasyEditForm()),
        Padding(
          padding: EdgeInsets.all(20),
          child: GradientButton("保存", height: 45, onPressed: () {
            SystemUtils.hideSoftKeyboard(context);
          }),
        )
      ],
      alignment: Alignment.topCenter,
    );
  }
}
