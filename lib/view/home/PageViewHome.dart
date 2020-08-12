import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';
import 'package:wan_flutter_app/widget/RefreshLayout.dart';

import '../../main.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class PageViewHome extends StatefulWidget {
  @override
  createState() => new PageViewHomeState();
}

final data = <Color>[
  Colors.purple[50],
  Colors.purple[100],
  Colors.purple[200],
  Colors.purple[300],
  Colors.purple[400],
  Colors.purple[500],
  Colors.purple[600],
  Colors.purple[700],
  Colors.purple[800],
  Colors.purple[900],
];
final List tabs = ["热门博文", "热门项目"];

class PageViewHomeState extends State<PageViewHome> with SingleTickerProviderStateMixin {
  int showWidget = 0;
  List<dynamic> bannerList = List();

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Future<List<RepResult>> mockNetworkData() async {
    return Future.wait([HttpUtils.instance.getFuture("banner")]).then((datas) {
      setState(() {
        bannerList = datas[0].data;
      });
    }).catchError((onError) {
      setState(() {
        showWidget = 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: ViewUtils.buildAvatar(),
            onPressed: () {
              eventBus.fire(DrawerEvent());
            },
          ),
          title: Text("主页", textAlign: TextAlign.center)),
      body: RefreshLayout(
        slivers: <Widget>[_buildSwiper(),_buildSliverFixedExtentList()],
        onRefresh: mockNetworkData,
        showWidget: showWidget,
      ),
    );*/

    return RefreshLayout(
      slivers: <Widget>[_buildSliverAppBar(), _buildTabBars(), _buildSliverFixedExtentList()],
      onRefresh: mockNetworkData,
      showWidget: showWidget,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190.0,
      leading: IconButton(
          icon: ViewUtils.buildAvatar(),
          onPressed: () {
            eventBus.fire(DrawerEvent());
          }),
      title: Text("主页", textAlign: TextAlign.center),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: Swiper(
          itemBuilder: (context, index) {
            return new Image.network(
              bannerList[index]['imagePath'],
              fit: BoxFit.fill,
            );
          },
          itemCount: bannerList.length,
          autoplay: true,
          autoplayDelay: 5000,
          pagination: SwiperPagination(),
        ),
      ),
    );
  }

  Widget _buildSwiper() {
    return SliverToBoxAdapter(
        child: Container(
            height: 180,
            child: Swiper(
              itemBuilder: (context, index) {
                return new Image.network(
                  bannerList[index]['imagePath'],
                  fit: BoxFit.fill,
                );
              },
              itemCount: bannerList.length,
              autoplay: true,
              autoplayDelay: 5000,
              pagination: SwiperPagination(),
            )));
  }

  Widget _buildTabBars() {
    return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverDelegate(
            child: Container(
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
          color: Theme.of(context).primaryColor,
        )));
  }

  Widget _buildSliverFixedExtentList() => SliverFixedExtentList(
        itemExtent: 60,
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 50,
                  color: data[index],
                  child: Text(
                    "$index",
                    style: TextStyle(color: Colors.white, shadows: [Shadow(color: Colors.black, offset: Offset(.5, .5), blurRadius: 2)]),
                  ),
                ),
            childCount: data.length),
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
