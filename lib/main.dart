import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Routes.dart';

var dio = Dio();

void main() {
  // 配置dio实例
  /*dio.options.baseUrl = "https://www.wanandroid.com";
  dio.options.connectTimeout = 5000; //5s
  dio.options.receiveTimeout = 3000;
  dio.interceptors.add(LogInterceptor());*/

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WanFlutter",
      routes: Routes.routes,
      initialRoute: "/",
    );
  }
}
