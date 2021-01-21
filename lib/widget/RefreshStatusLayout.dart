import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wan_flutter_app/widget/GradientButton.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc: easyrefresh配合NestedScrollView使用第一次刷新会自动弹到顶部
/// 可参考:https://github.com/xuelongqy/flutter_easyrefresh/issues/275
/// 解决方案是第一次刷新不使用自动刷新，详情见代码
const SUCCEED = 0;
const EMPTY = 1;
const ERROR = 2;

const PAGE_ZERO = 0;
const PAGE_ONE = 1;

typedef RefreshCallback = Future<void> Function(int page);
typedef StatusCallback = void Function(bool isSucceed, {int size});

class RefreshController extends EasyRefreshController {
  StatusCallback callback;

  addStatusCallback(StatusCallback onHttp) {
    this.callback = onHttp;
  }
}

class RefreshStatusLayout extends StatefulWidget {
  final RefreshCallback refreshCallback;
  final Widget child;
  final EasyRefreshController controller;
  final int initPage;
  final bool isOnLoad;

  RefreshStatusLayout({this.controller, this.initPage, this.child, this.refreshCallback, this.isOnLoad});

  @override
  createState() => RefreshStatusLayoutState();
}

class RefreshStatusLayoutState extends State<RefreshStatusLayout> with AutomaticKeepAliveClientMixin {
  RefreshController _controller;
  int initPage = PAGE_ZERO;
  int page = PAGE_ZERO;
  int showWidget = SUCCEED; //0.不显示 1.空视图 2.错误视图
  bool firstRefresh = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? RefreshController();
    initPage = widget.initPage ?? PAGE_ZERO;
    page = initPage;
    _controller.addStatusCallback((succeed, {size}) {
      firstRefresh = false;
      if (succeed) {
        if (this.isRefresh() && size == 0) {
          setState(() => showWidget = EMPTY);
        } else {
          setState(() => showWidget = SUCCEED);
        }
      } else {
        if (this.isRefresh()) {
          setState(() => showWidget = ERROR);
        } else {
          page--;
        }
      }
    });
  }

  bool isRefresh() {
    return page == initPage;
  }

  Widget emptyWidget() {
    return (showWidget == SUCCEED)
        ? null
        : Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(showWidget == EMPTY ? 'res/images/data_empty.png' : 'res/images/data_error.png', width: 100, height: 100),
                Divider(height: 10, color: Colors.transparent),
                Text(showWidget == EMPTY ? "没有数据哦~" : "加载失败了~"),
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
    super.build(context);
    Color color = Theme.of(context).primaryColor;
    return firstRefresh
        ? Container(
            alignment: Alignment.center,
            child: SpinKitThreeBounce(
              color: color,
              size: 25,
            ))
        : EasyRefresh(
            controller: _controller,
            header: MaterialHeader(),
            footer: BallPulseFooter(),
            emptyWidget: emptyWidget(),
            child: widget.child,
            firstRefresh: false,
            onRefresh: () async {
              page = initPage;
              widget.refreshCallback(page);
            },
            onLoad: (widget.isOnLoad ?? true)
                ? () async {
                    if (widget.isOnLoad ?? true) {
                      page++;
                      widget.refreshCallback(page);
                    }
                  }
                : null,
          );
  }

  @override
  bool get wantKeepAlive => true;
}
