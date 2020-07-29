import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wan_flutter_app/model/User.dart';

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
}
