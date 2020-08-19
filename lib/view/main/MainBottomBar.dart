import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/CallBack.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
///
class MainBottomBar extends StatefulWidget {
  MainBottomBar({this.currentIndex, this.callback});

  final TCallback callback;
  final int currentIndex;

  @override
  createState() => new MainBottomBarState();
}

final iconMap = {
  "主页": Icons.home,
  "体系": Icons.share,
  "项目": Icons.important_devices,
  "公众号": Icons.forum,
};

class MainBottomBarState extends State<MainBottomBar> {
  int _curPos = 0;

  List<String> get info => iconMap.keys.toList();

  List<Widget> _buildIcons(Color color) {
    return info.asMap().keys.map((i) {
      bool active = widget.currentIndex == i;
      return Padding(
        padding: EdgeInsets.only(top: 4, bottom: 5, right: i == 1 ? 40 : 0, left: i == 2 ? 40 : 0),
        child: GestureDetector(
          onTap: () {
            if (_curPos != i) {
              setState(() {
                _curPos = i;
              });
              widget.callback(i);
            }
          },
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Icon(iconMap[info[i]], color: active ? color : Colors.grey, size: 28),
              Text(info[i], style: TextStyle(color: active ? color : Colors.grey, fontSize: 10))
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BottomAppBar(
      elevation: 1,
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _buildIcons(theme.primaryColor),
      ),
    );
  }
}
