import 'http/RepResult.dart';

/// @author DeMon
/// Created on 2020/7/30.
/// E-mail 757454343@qq.com
/// Desc: 回调类

typedef HttpCallback = void Function(RepResult result); //网络请求回调

typedef Callback = void Function(); //无参回调

typedef TCallback = void Function(dynamic result); //泛型回调

