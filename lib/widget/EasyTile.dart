import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/29.
/// E-mail 757454343@qq.com
/// Desc:
class EasyTile extends StatelessWidget {
  EasyTile(this.title, {this.text, this.background, this.icon, this.onPressed});

  final Color background;
  final String title;
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return FlatButton(
        padding: EdgeInsets.all(0),
        //清除内边距
        onPressed: onPressed,
        disabledColor: background ?? Colors.white,
        color: background ?? Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: icon != null ? Icon(icon, color: theme.primaryColor) : null,
              title: Text(title),
              trailing: Wrap(
                spacing: 5,
                alignment: WrapAlignment.center,
                children: <Widget>[
                  Container(
                    width: 130,
                    child: Text(text ?? "", style: TextStyle(color: Colors.black54), maxLines: 2, overflow: TextOverflow.ellipsis),
                    alignment: Alignment.centerRight,
                  ),
                  Offstage(
                    child: Icon(Icons.arrow_forward_ios, size: 12),
                    offstage: onPressed == null,
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 16), child: Divider(height: 1, color: Colors.grey))
          ],
        ));
  }
}
