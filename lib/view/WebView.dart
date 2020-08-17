import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class WebViewPage extends StatefulWidget {
  @override
  createState() => new WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    dynamic data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(data['title']),
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  WebView(
                      initialUrl: data['url'],
                      javascriptMode: JavascriptMode.unrestricted,
                      onWebViewCreated: (WebViewController webViewController) {
                        _controller.complete(webViewController);
                      },
                      onPageStarted: (url) {
                        setState(() => visible = true);
                      },
                      onPageFinished: (url) {
                        setState(() => visible = false);
                      },
                      gestureNavigationEnabled: true,
                      navigationDelegate: (NavigationRequest request) {
                        String url = request.url;
                        //拦截：1.简书加载失败的页面 2.淘宝广告 3.百度广告
                        if (url.startsWith('jianshu://notes/') || url.contains('taobao') || url.contains('baidu')) {
                          return NavigationDecision.prevent;
                        }
                        return NavigationDecision.navigate;
                      }),
                  Visibility(visible: visible, child: SpinKitThreeBounce(color: Theme.of(context).primaryColor, size: 25)),
                ],
              ),
            ),
            Expanded(flex: 0, child: Container(height: 40, child: NavigationControls(_controller.future), color: Colors.white))
          ],
        ));
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture) : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _webViewControllerFuture,
        builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
          //final bool webViewReady = snapshot.connectionState == ConnectionState.done;
          final WebViewController controller = snapshot.data;
          return Center(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        Fluttertoast.showToast(msg: '当前无法后退！');
                      }
                    }),
                IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        Fluttertoast.showToast(msg: '当前无法前进！');
                      }
                    }),
                IconButton(
                    icon: const Icon(Icons.replay),
                    onPressed: () async {
                      await controller.reload();
                    })
              ],
            ),
          );
        });
  }
}
