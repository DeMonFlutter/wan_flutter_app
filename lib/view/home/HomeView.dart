import 'package:flutter/material.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/view/home/HomeSwiper.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as extended;

import 'HotBlog.dart';
import 'HotProject.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomeView extends StatefulWidget {
  @override
  createState() => new HomeViewState();
}

final List tabs = ["热门博文", "热门项目"];

class HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
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
        leading: ViewUtils.buildAvatarLeading(),
        title: Text("首页", textAlign: TextAlign.center),
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
                  indicatorColor: Colors.white,
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
