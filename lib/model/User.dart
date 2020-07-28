import 'dart:convert';

import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/utils/StringUtils.dart';

/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:
class User {
  bool admin;
  List<String> chapterTops;
  int coinCount;
  List<String> collectIds;
  String email;
  String icon;
  int id;
  String nickname;
  String password;
  String publicName;
  String token;
  int type;
  String username;
  String desc;

  User(
      {this.admin,
      this.chapterTops,
      this.coinCount,
      this.collectIds,
      this.email,
      this.icon,
      this.id,
      this.nickname,
      this.password,
      this.publicName,
      this.token,
      this.type,
      this.username,
      this.desc});

  static User _instance;

  ///通用全局单例，第一次使用时初始化
  User._internal() {
    SPUtils.get(Const.USER_INFO, "", (str) {
      print(str);
      if (!StringUtils.isEmpty(str)) {
        fromJson(json.decode(str));
      }
    });
  }

  static User getInstance() {
    if (_instance == null) {
      _instance = User._internal();
    }
    return _instance;
  }

  /**
   * 本地存储登录信息，达到持久化效果
   */
  setUser(Map<String, dynamic> map) {
    SPUtils.setData(Const.USER_INFO, json.encode(map));
    _instance = User._internal();
  }

  /**
   * 设置头像，简介等信息
   * wanAndroid Api暂无修改头像简介等信息的字段，使用SP暂存本地
   */
  setInfo({String path = "", String desc = ""}) {
    SPUtils.get(Const.USER_INFO, "", (str) {
      if (!StringUtils.isEmpty(str)) {
        Map<String, dynamic> user = json.decode(str);
        user['icon'] = path;
        user['desc'] = desc;
        setUser(user);
      }
    });
  }

  fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    chapterTops = json['chapterTops'].cast<String>();
    coinCount = json['coinCount'];
    collectIds = json['collectIds'].cast<String>();
    email = json['email'];
    icon = json['icon'];
    id = json['id'];
    nickname = json['nickname'];
    password = json['password'];
    publicName = json['publicName'];
    token = json['token'];
    type = json['type'];
    username = json['username'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['chapterTops'] = this.chapterTops;
    data['coinCount'] = this.coinCount;
    data['collectIds'] = this.collectIds;
    data['email'] = this.email;
    data['icon'] = this.icon;
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['password'] = this.password;
    data['publicName'] = this.publicName;
    data['token'] = this.token;
    data['type'] = this.type;
    data['username'] = this.username;
    data['desc'] = this.desc;
    return data;
  }

  @override
  String toString() {
    return 'User{admin: $admin, email: $email, icon: $icon, id: $id, nickname: $nickname, token: $token, username: $username}';
  }
}
