import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/31.
/// E-mail 757454343@qq.com
/// Desc:
class EasyEditForm extends StatelessWidget {
  EasyEditForm({
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.counterText,
  });

  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final String counterText;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    OutlineInputBorder createBorder(Color color) {
      return OutlineInputBorder(borderSide: BorderSide(color: color), borderRadius: BorderRadius.all(Radius.circular(10)));
    }

    return TextFormField(
        decoration: InputDecoration(
      border: createBorder(theme.primaryColor),
      focusedBorder: createBorder(theme.primaryColor),
      enabledBorder: createBorder(theme.primaryColor),
      disabledBorder: createBorder(Colors.grey),
      errorBorder: createBorder(theme.errorColor),
      focusedErrorBorder: createBorder(theme.errorColor),
      labelText: "labelText",
      helperText: "help me",
      helperStyle: TextStyle(color: Theme.of(context).accentColor),
      suffixIcon: Icon(Icons.clear, color: Colors.black45),
      counterText: counterText,
      counterStyle: TextStyle(color: Theme.of(context).primaryColorDark),
      prefixIcon: prefixIcon,
      fillColor: Color(0x110099ee),
      filled: true,
      errorText: "123",
      errorMaxLines: 1,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      hintMaxLines: 1,
    ));
  }
}
