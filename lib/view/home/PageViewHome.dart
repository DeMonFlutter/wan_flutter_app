import 'package:flutter/material.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';

import '../../main.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class PageViewHome extends StatefulWidget {

  @override
  createState() => new PageViewHomeState();
}

class PageViewHomeState extends State<PageViewHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: ViewUtils.buildAvatar(),
          onPressed: () {
            eventBus.fire(DrawerEvent());
          },
        ),
        title: Text(
          "主页",
          textAlign: TextAlign.center,
        ),
      ),
      body: Text("主页"),
    );
  }
}
