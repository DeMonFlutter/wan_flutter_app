import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/CallBack.dart';
import 'package:wan_flutter_app/widget/OptionView.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class ListPickView extends StatefulWidget {
  ListPickView(this.dataList, {this.callback});

  final List<dynamic> dataList;
  final TCallback callback;

  @override
  createState() => new ListPickViewState();
}

class ListPickViewState extends State<ListPickView> {
  String initStr = '';
  dynamic data;

  List<Widget> _buildList() {
    return widget.dataList
        .map((e) => Container(
              alignment: Alignment.center,
              height: 50,
              child: Text(
                e['name'],
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ))
        .toList();
  }

  @override
  void initState() {
    initStr = widget.dataList[0]['name'];
    data = widget.dataList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      height: 400,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              OptionView(child: Text('取消', style: TextStyle(color: theme.primaryColor, fontSize: 16)), onPressed: () => Navigator.pop(context)),
              Text(initStr),
              OptionView(
                  child: Text('确认', style: TextStyle(color: theme.primaryColor, fontSize: 16)),
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.callback != null) {
                      widget.callback(data);
                    }
                  }),
            ],
          ),
          Expanded(
            child: ListWheelScrollView.useDelegate(
              perspective: 0.008,
              itemExtent: 50,
              useMagnifier: true,
              overAndUnderCenterOpacity: 0.5,
              magnification: 1.2,
              onSelectedItemChanged: (index) {
                data = widget.dataList[index];
                setState(() {
                  initStr = widget.dataList[index]['name'];
                });
              },
              childDelegate: ListWheelChildListDelegate(children: _buildList()),
            ),
          )
        ],
      ),
    );
  }
}
