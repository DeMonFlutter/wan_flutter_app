import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';

import 'CallBack.dart';

/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:
///
class DialogUtils {

  /// http加载框 1.拦截返回框 2.空白区域点击不消失
  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false; //拦截返回键
              },
              child: GestureDetector(
                onTap: () {}, //空白区域点击不消失
                child: UnconstrainedBox(
                  constrainedAxis: Axis.vertical,
                  child: SizedBox(
                      width: 250,
                      child: AlertDialog(
                          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                        SpinKitFadingCube(color: Theme.of(context).primaryColor),
                        Padding(padding: EdgeInsets.only(top: 25.0), child: Text("加载中，请稍后...")),
                      ]))),
                ),
              ));
        });
  }

  static showConfirmDialog(BuildContext context, String content, Callback callback, {String title}) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: CupertinoAlertDialog(
                title: Text(StringUtils.isEmpty(title) ? '提示' : title, style: TextStyle(color: Colors.black87, fontSize: 16)),
                content: Padding(
                  padding: EdgeInsets.only(top: 18.0),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: <Widget>[
                      Text(
                        content,
                        style: TextStyle(color: Colors.black87),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text("算了", style: TextStyle(fontSize: 14)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: Text(
                      "好的",
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      callback();
                    },
                  ),
                ]),
          );
        });
  }
}
