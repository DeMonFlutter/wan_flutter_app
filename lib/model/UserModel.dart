import 'package:flutter/material.dart';

import 'User.dart';

/// @author DeMon
/// Created on 2020/7/30.
/// E-mail 757454343@qq.com
/// Desc:
class UserModel extends ChangeNotifier {
  User user = User.getInstance();

  changeUser() {
    user = User.getInstance();
    notifyListeners();
  }
}
