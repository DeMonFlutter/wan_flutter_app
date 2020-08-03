import 'package:flutter/material.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
///
typedef Callback = void Function(int result);

class HomeBottomBar extends StatefulWidget {
  HomeBottomBar({this.currentIndex, this.callback});

  final Callback callback;
  final int currentIndex;

  @override
  createState() => new HomeBottomBarState();
}

final iconMap = {"主页": Icons.home, "收藏": Icons.favorite};

class HomeBottomBarState extends State<HomeBottomBar> {
  int _curPos = 0;

  List<String> get info => iconMap.keys.toList();

  List<Widget> _buildIcons(Color color) {
    return info.asMap().keys.map((i) {
      bool active = widget.currentIndex == i;
      return Padding(
        padding: EdgeInsets.all(5),
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
              Icon(iconMap[info[i]], color: active ? color : Colors.grey, size: 25),
              Text(info[i], style: TextStyle(color: active ? color : Colors.grey, fontSize: 12))
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
