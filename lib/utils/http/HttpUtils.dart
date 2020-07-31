import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    }
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
          throw ('${result.errorCode}：${result.errorMsg}');
        }
      } else {
        throw ('${response.statusCode}：${response.statusMessage}');
      }
    }).then((onValue) {
      callback(onValue);
    }).catchError((e) {
      print('$url--$e');
      Fluttertoast.showToast(msg: '请求失败：$e');
    });
  }

  /// wanAndroid Api post请求封装
  post(BuildContext context, String url, HttpCallback callback, {bool isShowDialog = true, int page = -1, bool isJson = false, Map<String, dynamic> data}) {
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
          throw ('${result.errorCode}-${result.errorMsg}');
        }
      } else {
        throw ('${response.statusCode}-${response.statusMessage}');
      }
    }).then((onValue) {
      callback(onValue);
    }).catchError((e) {
      print('$url--$e');
      Fluttertoast.showToast(msg: '请求失败：$e');
    });
  }
}
