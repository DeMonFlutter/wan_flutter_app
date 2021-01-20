
/// @author DeMon
/// Created on 2020/8/18.
/// E-mail 757454343@qq.com
/// Desc:
class ClassModel {
  List<ClassModel> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  ClassModel({this.children, this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

  ClassModel.fromJson(Map<String, dynamic> map) {
    if (map['children'] != null) {
      children = new List<ClassModel>();
      map['children'].forEach((v) {
        children.add(new ClassModel.fromJson(v));
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
    return 'ClassModel{id: $id, name: $name, children: $children,}';
  }
}
