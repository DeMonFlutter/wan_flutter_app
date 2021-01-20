import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wan_flutter_app/utils/DialogUtils.dart';
import '../CallBack.dart';
import 'RepResult.dart';

const String _kBaseUrl = "https://www.wanandroid.com/";
const int _kReceiveTimeout = 15000;
const int _kSendTimeout = 15000;
const int _kConnectTimeout = 15000;

/// @author DeMon
/// Created on 2020/7/27.
/// E-mail 757454343@qq.com
/// Desc:http请求
/// 由于：NoSuchMethodError The getter focusScopeNode was called on null-->https://blog.csdn.net/u011050129/article/details/106711246
/// 所以Navigator.of(context).pop()不要放在whenComplete中，避免请求结束的页面跳转出现bug
class HttpUtils {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio;

  factory HttpUtils() => getInstance();

  static HttpUtils get instance => getInstance();
  static HttpUtils _instance;

  ///通用全局单例，第一次使用时初始化
  HttpUtils._internal() {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        baseUrl: _kBaseUrl,
        connectTimeout: _kReceiveTimeout,
        receiveTimeout: _kConnectTimeout,
        sendTimeout: _kSendTimeout,
      ));
      _dio.interceptors.add(LogInterceptor());
      //cookies持久化
      setCookie();
    }
  }

  ///设置cookie
  void setCookie() async {
    // 获取文档目录的路径
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dir = appDocDir.path + "/.cookies/";
    print('cookie路径地址：' + dir);
    var cookieJar = PersistCookieJar(dir: dir);
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  static HttpUtils getInstance() {
    if (_instance == null) {
      _instance = HttpUtils._internal();
    }
    return _instance;
  }

  void rebase(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  Future<RepResult> getFuture(String url, {int page = -1, bool isJson = true, Map<String, dynamic> param}) async {
    if (page != -1) {
      url += "/$page";
    }
    if (isJson) {
      url += "/json";
    }
    var response = await _dio.get(url, queryParameters: param);
    if (response.statusCode == HttpStatus.ok) {
      var result = RepResult.fromJson(response.data);
      print(result.toString());
      if (result.errorCode == 0) {
        return result;
      } else {
        throw ('${result.errorCode},${result.errorMsg}');
      }
    } else {
      throw ('${response.statusCode},${response.statusMessage}');
    }
  }

  /// wanAndroid Api get请求封装
  get(BuildContext context, String url, HttpCallback callback, {bool isShowDialog = true, bool isJson = true, int page = -1, Map<String, dynamic> param}) {
    Future.sync(() async {
      if (isShowDialog) {
        DialogUtils.showLoadingDialog(context);
      }
      if (page != -1) {
        url += "/$page";
      }
      if (isJson) {
        url += "/json";
      }
      var response = await _dio.get(url, queryParameters: param);
      if (isShowDialog) {
        Navigator.of(context).pop();
      }
      if (response.statusCode == HttpStatus.ok) {
        var result = RepResult.fromJson(response.data);
        print(result.toString());
        if (result.errorCode == 0) {
          return result;
        } else {
          throw ('${result.errorCode},${result.errorMsg}');
        }
      } else {
        throw ('${response.statusCode},${response.statusMessage}');
      }
    }).then((onValue) {
      callback(onValue);
    }).catchError((e) {
      if (isShowDialog) {
        Navigator.of(context).pop();
      }
      print('$url--$e');
      Fluttertoast.showToast(msg: '请求失败：$e');
    });
  }

  Future<RepResult> postFuture(String url, {int page = -1, bool isJson = true, Map<String, dynamic> data}) async {
    if (page != -1) {
      url += "/$page";
    }
    if (isJson) {
      url += "/json";
    }
    var response = await _dio.post(url, data: new FormData.fromMap(data));
    if (response.statusCode == HttpStatus.ok) {
      var result = RepResult.fromJson(response.data);
      print(result.toString());
      if (result.errorCode == 0) {
        return result;
      } else {
        throw ('${result.errorCode},${result.errorMsg}');
      }
    } else {
      throw ('${response.statusCode},${response.statusMessage}');
    }
  }

  /// wanAndroid Api post请求封装
  post(BuildContext context, String url, HttpCallback callback, {bool isShowDialog = true, int page = -1, bool isJson = true, Map<String, dynamic> data}) {
    Future.sync(() async {
      if (isShowDialog) {
        DialogUtils.showLoadingDialog(context);
      }
      if (page != -1) {
        url += "/$page";
      }
      if (isJson) {
        url += "/json";
      }
      var response = await _dio.post(url, data: new FormData.fromMap(data));
      if (isShowDialog) {
        Navigator.of(context).pop();
      }
      if (response.statusCode == HttpStatus.ok) {
        var result = RepResult.fromJson(response.data);
        print(result.toString());
        if (result.errorCode == 0) {
          return result;
        } else {
          throw ('${result.errorCode},${result.errorMsg}');
        }
      } else {
        throw ('${response.statusCode},${response.statusMessage}');
      }
    }).then((onValue) {
      callback(onValue);
    }).catchError((e) {
      if (isShowDialog) {
        Navigator.of(context).pop();
      }
      print('$url--$e');
      Fluttertoast.showToast(msg: '请求失败：$e');
    });
  }
}
