import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';
import 'package:wan_flutter_app/view/home/HomeSwiper.dart';
import 'file:///D:/ITCode/Flutter/wan_flutter_app/lib/view/home/hot/HotBlog.dart';
import 'file:///D:/ITCode/Flutter/wan_flutter_app/lib/view/home/hot/HotProject.dart';
import '../../main.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class PageViewHome extends StatefulWidget {
  @override
  createState() => new PageViewHomeState();
}

final List tabs = ["热门博文", "热门项目"];

class PageViewHomeState extends State<PageViewHome> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return extended.NestedScrollView(
      controller: _scrollController,
      pinnedHeaderSliverHeightBuilder: () {
        return MediaQuery.of(context).padding.top + kToolbarHeight;
      },
      innerScrollPositionKeyBuilder: () {
        return Key('HomeTab${_tabController.index}');
      },
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[_buildSliverAppBar(), _buildTabBars()];
      },
      body: _buildTabBarView(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
        expandedHeight: 180.0,
        leading: IconButton(
            icon: ViewUtils.buildAvatar(),
            onPressed: () {
              eventBus.fire(DrawerEvent());
            }),
        title: Text("主页", textAlign: TextAlign.center),
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax, //视差效果
          background: HomeSwiper(),
        ));
  }

  Widget _buildTabBars() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverDelegate(
            child: Card(
                elevation: 3.0,
                color: Theme.of(context).primaryColor,
                margin: new EdgeInsets.all(0.0),
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                ))));
  }

  Widget _buildTabBarView() => TabBarView(
        controller: _tabController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          extended.NestedScrollViewInnerScrollPositionKeyWidget(Key('HomeTab0'), HotBlogPage()),
          extended.NestedScrollViewInnerScrollPositionKeyWidget(Key('HomeTab1'), HotProjectPage()),
        ],
      );
}

class _SliverDelegate extends SliverPersistentHeaderDelegate {
  _SliverDelegate({
    @required this.child,
  });

  final Widget child; //孩子
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
