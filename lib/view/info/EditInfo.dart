import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter_app/model/User.dart';
import 'package:wan_flutter_app/model/UserModel.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';
import 'package:wan_flutter_app/widget/EasyEditForm.dart';
import 'package:wan_flutter_app/widget/EasyForm.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class EditInfoPage extends StatefulWidget {
  @override
  createState() => new EditInfoPageState();
}

final Map<int, EditInfo> infos = {
  0: EditInfo("昵称", "编辑您的昵称", 15, 1, TextInputType.text),
  1: EditInfo("邮箱", "编辑您的邮箱", 64, 1, TextInputType.emailAddress),
  2: EditInfo("个性签名", "编辑您的个性签名", 150, 3, TextInputType.text),
};

class EditInfoPageState extends State<EditInfoPage> {
  String counterText = "";
  String content;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments as Map;
    int what = arguments['what'];
    var editInfo = infos[what];
    var initStr = arguments['content'];
    return CenterScaffold(
      "编辑",
      <Widget>[
        EasyForm(
          children: <Widget>[
            EasyEditForm(
              initialValue: initStr,
              maxLines: editInfo.maxLines,
              maxLength: editInfo.maxLength,
              keyboardType: editInfo.keyboardType,
              onChanged: (str) {
                setState(() {
                  counterText = "${str.trim().length}/${editInfo.maxLength}";
                });
                content = str;
              },
              labelText: editInfo.labelText,
              hintText: editInfo.hintText,
              counterText: counterText,
              editMode: EditMode.clear,
              validator: (v) {
                return StringUtils.isEmpty(v) ? "编辑内容不能为空" : null;
              },
            )
          ],
          callback: () {
            switch (what) {
              case 0:
                User.getInstance().setInfo(nickname: content);
                break;
              case 1:
                User.getInstance().setInfo(email: content);
                break;
              case 2:
                User.getInstance().setInfo(desc: content);
                break;
            }
            Navigator.of(context).pop();
          },
          buttonText: "保存",
        )
      ],
      alignment: Alignment.topCenter,
    );
  }
}

class EditInfo {
  String labelText;
  String hintText;
  int maxLength;

  int maxLines;
  TextInputType keyboardType;

  EditInfo(this.labelText, this.hintText, this.maxLength, this.maxLines, this.keyboardType);

  @override
  String toString() {
    return 'EditInfo{labelText: $labelText, hintText: $hintText, maxLength: $maxLength, maxLines: $maxLines}';
  }
}
