import 'dart:convert';

import 'PagingData.dart';

/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:http通用数据
class RepResult {
  var data;
  int errorCode;
  String errorMsg;
  PagingData pagingData; //分页数据

  RepResult(this.data, this.errorCode, this.errorMsg);

  RepResult.fromJson(Map<String, dynamic> map) {
    data = map['data'] != null ? map['data'] : null;
    errorCode = map['errorCode'];
    errorMsg = map['errorMsg'];
    if (data != null && !(data is List<dynamic>)) {
      pagingData = data['datas'] != null ? PagingData.fromJson(data) : null;
    }
  }

  @override
  String toString() {
    return 'RepResult{code: $errorCode, msg: $errorMsg, data: $data}';
  }
}
