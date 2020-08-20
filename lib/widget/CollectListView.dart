import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';

/// @author DeMon
/// Created on 2020/8/20.
/// E-mail 757454343@qq.com
/// Desc: 左滑搜藏列表
class CollectListView extends StatefulWidget {
  CollectListView(this.data, this.child);

  final Widget child;
  final dynamic data;

  @override
  State<StatefulWidget> createState() => CollectListViewState();
}

class CollectListViewState extends State<CollectListView> {
  bool isCollect;

  @override
  void initState() {
    isCollect = widget.data['collect'];
    super.initState();
  }

  doCollect() {
    String url = isCollect ? 'lg/uncollect_originId/' : 'lg/collect/';
    HttpUtils.instance.post(context, url + '${widget.data['id']}', (result) {
      setState(() {
        isCollect = !isCollect;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable.builder(
      child: isCollect
          ? Banner(
              message: '已收藏',
              location: BannerLocation.topEnd,
              color: Theme.of(context).primaryColor,
              child: widget.child,
            )
          : widget.child,
      actionPane: SlidableScrollActionPane(),
      secondaryActionDelegate: CollectDelegate(isCollect: isCollect, onTap: () => doCollect()),
    );
  }
}

class CollectDelegate extends SlideActionDelegate {
  CollectDelegate({this.isCollect, this.onTap});

  final bool isCollect;
  final VoidCallback onTap;

  @override
  int get actionCount => 1;

  @override
  Widget build(BuildContext context, int index, Animation<double> animation, SlidableRenderingMode step) {
    return IconSlideAction(
      caption: isCollect ? '取消收藏' : '收藏',
      color: isCollect ? Colors.blue : Colors.red,
      icon: isCollect ? Icons.favorite : Icons.favorite_border,
      onTap: onTap,
    );
  }
}
