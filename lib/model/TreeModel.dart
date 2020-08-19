import 'dart:convert';

/// @author DeMon
/// Created on 2020/8/18.
/// E-mail 757454343@qq.com
/// Desc:
class TreeModel {
  List<TreeModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  TreeModel({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

  TreeModel.fromJson(Map<String, dynamic> map) {
    if (map['children'] != null) {
      children = new List<TreeModel>();
      map['children'].forEach((v) {
        children.add(new TreeModel.fromJson(v));
      });
    }
    courseId = map['courseId'];
    id = map['id'];
    name = map['name'];
    order = map['order'];
    parentChapterId = map['parentChapterId'];
    userControlSetTop = map['userControlSetTop'];
    visible = map['visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    data['courseId'] = this.courseId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['parentChapterId'] = this.parentChapterId;
    data['userControlSetTop'] = this.userControlSetTop;
    data['visible'] = this.visible;
    return data;
  }

  @override
  String toString() {
    return 'TreeModel{id: $id, name: $name, children: $children,}';
  }
}
