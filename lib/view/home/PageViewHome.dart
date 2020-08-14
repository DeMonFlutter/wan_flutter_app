import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';
import 'package:wan_flutter_app/view/home/HotBlog.dart';
import 'package:wan_flutter_app/view/home/HotProject.dart';
import '../../main.dart';

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
  int showWidget = 0;

  TabController _timeTabController;

  @override
  void initState() {
    _timeTabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: _buildSliverAppBar(),
          ),
          _buildTabBars()
        ];
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
          background: _buildSwiper(),
        ));
  }

  Widget _buildSwiper() {
    return FutureBuilder<RepResult>(
      future: HttpUtils.instance.getFuture("banner"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List bannerList = snapshot.data.data;
          if (snapshot.hasError || bannerList.isEmpty) {
            return Image.asset(
              'res/images/bg.jpg',
              fit: BoxFit.fill,
            );
          } else {
            return Swiper(
              itemBuilder: (context, index) {
                return new Image.network(
                  bannerList[index]['imagePath'],
                  fit: BoxFit.cover,
                );
              },
              itemCount: bannerList.length,
              autoplay: bannerList.length > 1,
              autoplayDelay: 5000,
              pagination: SwiperPagination(),
            );
          }
        } else {
          return Image.asset('res/images/bg.jpg');
        }
      },
    );
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
                  controller: _timeTabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                ))));
  }

  Widget _buildTabBarView() => SafeArea(
        top: false,
        bottom: false,
        child: TabBarView(controller: _timeTabController, children: <Widget>[HotBlogPage(), HotProjectPage()]),
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
