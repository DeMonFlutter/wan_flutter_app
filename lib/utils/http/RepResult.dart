/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:http通用数据
class RepResult {
  var data;
  int errorCode;
  String errorMsg;

  RepResult(this.data, this.errorCode, this.errorMsg);

  RepResult.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? json['data'] : null;
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }

  @override
  String toString() {
    return 'RepResult{code: $errorCode, msg: $errorMsg, data: $data}';
  }
}
