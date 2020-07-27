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
        this.username});

  static User _instance;

  ///通用全局单例，第一次使用时初始化
  User._internal() {
  }

  static User getInstance() {
    if (_instance == null) {
      _instance = User._internal();
    }
    return _instance;
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
    return data;
  }

  @override
  String toString() {
    return 'User{admin: $admin, email: $email, icon: $icon, id: $id, nickname: $nickname, token: $token, username: $username}';
  }
}
