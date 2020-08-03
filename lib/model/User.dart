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

  User._internal() {
    init();
  }

  /// 通用全局单例，第一次使用时初始化
  /// 由于这里使用SP存储作为持久化，SP读取异步且耗时
  /// 所以使用前需要提前初始化（如在起始过渡页），避免初次使用值为空的现象
  static User getInstance() {
    if (_instance == null) {
      _instance = User._internal();
    }
    return _instance;
  }

  init() {
    SPUtils.get(Const.USER_INFO, "", (str) {
      print("User init = $str");
      if (!StringUtils.isEmpty(str)) {
        fromJson(json.decode(str));
      }
    });
  }

  /// 本地存储登录信息，达到持久化效果
  setUser(Map<String, dynamic> map) {
    fromJson(map);
    SPUtils.setData(Const.USER_INFO, json.encode(map));
  }

  /// 设置头像，简介等信息
  /// wanAndroid Api暂无修改头像简介等信息的字段，使用SP暂存本地
  setInfo({String path, String desc, String email, String nickname}) {
    SPUtils.get(Const.USER_INFO, "", (str) {
      if (!StringUtils.isEmpty(str)) {
        Map<String, dynamic> user = json.decode(str);
        if (!StringUtils.isEmpty(path)) {
          user['icon'] = path;
        }
        if (!StringUtils.isEmpty(desc)) {
          user['desc'] = desc;
        }
        if (!StringUtils.isEmpty(email)) {
          user['email'] = email;
        }
        if (!StringUtils.isEmpty(nickname)) {
          user['nickname'] = nickname;
        }
        setUser(user);
      }
    });
  }

  String getDesc() {
    return StringUtils.isEmpty(_instance.desc) ? "I decide what tide to bring.我的命运，由我做主。" : _instance.desc;
  }

  fromJson(Map<String, dynamic> json) {
    _instance.admin = json['admin'];
    _instance.chapterTops = json['chapterTops'].cast<String>();
    _instance.coinCount = json['coinCount'];
    _instance.collectIds = json['collectIds'].cast<String>();
    _instance.email = json['email'];
    _instance.icon = json['icon'];
    _instance.id = json['id'];
    _instance.nickname = json['nickname'];
    _instance.password = json['password'];
    _instance.publicName = json['publicName'];
    _instance.token = json['token'];
    _instance.type = json['type'];
    _instance.username = json['username'];
    _instance.desc = json['desc'];
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
