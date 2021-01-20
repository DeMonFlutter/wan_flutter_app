import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class RefreshLayout extends StatefulWidget {
  final OnRefreshCallback onRefresh;
  final OnLoadCallback onLoad;
  final List<Widget> slivers;

  //0 不显示 1 空视图 2.错误视图
  final int showWidget;

  RefreshLayout({this.slivers, this.onRefresh, this.onLoad, this.showWidget});

  @override
  createState() => new RefreshLayoutState();
}

class RefreshLayoutState extends State<RefreshLayout> {
  EasyRefreshController _controller = EasyRefreshController();

  @override
  void initState() {
    super.initState();
  }

  Widget emptyWidget() {
    return (widget.showWidget == null || widget.showWidget == 0)
        ? null
        : Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(widget.showWidget == 1 ? 'res/images/data_empty.png' : 'res/images/data_error.png', width: 100, height: 100),
                Divider(height: 10, color: Colors.transparent),
                Text(widget.showWidget == 1 ? "没有数据哦~" : "加载失败了~"),
                Divider(height: 10, color: Colors.transparent),
                GradientButton(
                  "重新加载",
                  height: 35,
                  width: 100,
                  onPressed: () {
                    _controller.callRefresh();
                  },
                )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return EasyRefresh.custom(
      controller: _controller,
      header: MaterialHeader(),
      footer: BallPulseFooter(color: color),
      firstRefresh: true,
      firstRefreshWidget: Container(
          alignment: Alignment.center,
          child: SpinKitThreeBounce(
            color: Theme.of(context).primaryColor,
            size: 25,
          )),
      emptyWidget: emptyWidget(),
      slivers: widget.slivers,
      onRefresh: widget.onRefresh,
      onLoad: widget.onLoad,
    );
  }
}
