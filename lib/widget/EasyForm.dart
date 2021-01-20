import 'package:flutter/cupertino.dart';
import 'package:wan_flutter_app/utils/CallBack.dart';
import 'package:wan_flutter_app/utils/SystemUtils.dart';

import 'GradientButton.dart';

/// @author DeMon
/// Created on 2020/8/3.
/// E-mail 757454343@qq.com
/// Desc: 多个TextFormField+一个button的表单，点击button可自动校验
class EasyForm extends StatefulWidget {
  EasyForm({this.children, this.callback, this.buttonText});

  final List<Widget> children;
  final String buttonText;
  final Callback callback;

  @override
  State<StatefulWidget> createState() {
    return EasyFormState();
  }
}

class EasyFormState extends State<EasyForm> {
  GlobalKey _formKey = new GlobalKey<FormState>();

  List<Widget> _buildChildren() {
    List<Widget> list = <Widget>[];
    widget.children?.forEach((item) {
      list.add(Padding(padding: EdgeInsets.all(20), child: item));
    });

    list.add(Padding(
      padding: EdgeInsets.all(20),
      child: GradientButton(
        widget.buttonText ?? "确定",
        height: 45,
        onPressed: () {
          SystemUtils.hideSoftKeyboard(context);
          FormState form = _formKey.currentState;
          if (form.validate()) {
            widget.callback();
          }
        },
      ),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: _buildChildren()),
    );
  }
}
