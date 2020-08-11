import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter_app/event/DrawerEvent.dart';
import 'package:wan_flutter_app/utils/ViewUtils.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';

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

class PageViewHomeState extends State<PageViewHome> {
  List<dynamic> bannerList = List();

  @override
  void initState() {
    super.initState();
    HttpUtils.instance.get(context, "banner", (rep) {
      setState(() {
        bannerList = rep.data;
      });
    }, isShowDialog: false);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[_buildSliverAppBar(), _buildSliverFixedExtentList()],
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 190,
      leading: IconButton(
        icon: ViewUtils.buildAvatar(),
        onPressed: () {
          eventBus.fire(DrawerEvent());
        },
      ),
      title: Text("主页", textAlign: TextAlign.center),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        //title: Text("主页", textAlign: TextAlign.center),
        //titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
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
          pagination: SwiperPagination(),
        ),
      ),
    );
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
