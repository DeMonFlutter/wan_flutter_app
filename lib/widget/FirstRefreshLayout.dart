import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc: easyrefresh配合NestedScrollView使用第一次刷新会自动弹到顶部
/// 可参考:https://github.com/xuelongqy/flutter_easyrefresh/issues/275
/// 解决方案是第一次刷新不使用自动刷新，详情见代码
class FirstRefreshLayout extends StatefulWidget {
  final OnRefreshCallback onRefresh;
  final OnLoadCallback onLoad;
  final Widget child;
  final bool firstRefresh;
  final EasyRefreshController controller;
  final int showWidget; //0 不显示 1 空视图 2.错误视图

  FirstRefreshLayout({this.controller, this.child, this.onRefresh, this.onLoad, this.showWidget, this.firstRefresh});

  @override
  createState() => new FirstRefreshLayoutState();
}

class FirstRefreshLayoutState extends State<FirstRefreshLayout> with AutomaticKeepAliveClientMixin {
  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? EasyRefreshController();
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
    return widget.firstRefresh
        ? Container(
            alignment: Alignment.center,
            child: SpinKitThreeBounce(
              color: color,
              size: 25,
            ))
        : EasyRefresh(
            controller: _controller,
            header: BallPulseHeader(),
            footer: BallPulseFooter(color: color),
            emptyWidget: emptyWidget(),
            child: widget.child,
            firstRefresh: false,
            onRefresh: widget.onRefresh,
            onLoad: widget.onLoad,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
