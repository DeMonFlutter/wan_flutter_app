class PublicModel {
    int courseId;
    int id;
    String name;
    int order;
    int parentChapterId;
    bool userControlSetTop;
    int visible;

    PublicModel({this.courseId, this.id, this.name, this.order, this.parentChapterId, this.userControlSetTop, this.visible});

    factory PublicModel.fromJson(Map<String, dynamic> json) {
        return PublicModel(
            courseId: json['courseId'], 
            id: json['id'], 
            name: json['name'], 
            order: json['order'], 
            parentChapterId: json['parentChapterId'], 
            userControlSetTop: json['userControlSetTop'], 
            visible: json['visible'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['courseId'] = this.courseId;
        data['id'] = this.id;
        data['name'] = this.name;
        data['order'] = this.order;
        data['parentChapterId'] = this.parentChapterId;
        data['userControlSetTop'] = this.userControlSetTop;
        data['visible'] = this.visible;
        return data;
    }
}