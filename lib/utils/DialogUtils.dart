import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:
class DialogUtils {
  /**
   * http加载框 1.拦截返回框 2.空白区域点击不消失
   */
  static showHttpDialog(BuildContext context) {
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
                        CircularProgressIndicator(),
                        Padding(padding: EdgeInsets.only(top: 25.0), child: Text("加载中，请稍后...")),
                      ]))),
                ),
              ));
        });
  }

  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(Duration(seconds: 2)).then((e) {
            Navigator.of(context).pop();
          });
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: SizedBox(
                width: 250,
                child: AlertDialog(
                    content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(padding: EdgeInsets.only(top: 25.0), child: Text("加载中，请稍后...")),
                ]))),
          );
        });
  }
}
