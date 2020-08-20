import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/model/User.dart';

import '../main.dart';
import 'StringUtils.dart';

/// @author DeMon
/// Created on 2020/7/29.
/// E-mail 757454343@qq.com
/// Desc:
class ViewUtils {
  static Widget buildAvatar({double radius = 36.0}) {
    if (!StringUtils.isEmpty(User.getInstance().icon)) {
      return CircleAvatar(radius: radius, backgroundImage: FileImage(File(User.getInstance().icon)));
    }
    return CircleAvatar(radius: radius, backgroundImage: AssetImage('res/images/D.png'));
  }

  static Widget buildAvatarLeading() {
    return IconButton(
        icon: buildAvatar(),
        onPressed: () {
          eventBus.fire(DrawerEvent());
        });
  }

  static Widget buildLoading(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 250,
          height: 200,
          child: Card(
              child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            size: 25,
          )),
        ));
  }
}
