import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wan_flutter_app/Routes.dart';
import 'package:wan_flutter_app/utils/http/HttpUtils.dart';
import 'package:wan_flutter_app/utils/http/RepResult.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
class HomeSwiper extends StatefulWidget {
  @override
  createState() => new HomeSwiperState();
}

class HomeSwiperState extends State<HomeSwiper> {
  var _futureBuilderFuture;

  @override
  void initState() {
    _futureBuilderFuture = HttpUtils.instance.getFuture("banner");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RepResult>(
      future: _futureBuilderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Image.asset('res/images/bg.jpg', fit: BoxFit.cover);
          } else {
            List bannerList = snapshot.data.data;
            if (bannerList.isEmpty) {
              return Image.asset('res/images/bg.jpg', fit: BoxFit.cover);
            } else {
              return Swiper(
                itemBuilder: (context, index) {
                  return new Image.network(bannerList[index]['imagePath'], fit: BoxFit.cover);
                },
                itemCount: bannerList.length,
                autoplay: bannerList.length > 1,
                autoplayDelay: 10000,
                duration: 1000,
                pagination: SwiperPagination(),
                onTap: (index) {
                  var data = bannerList[index];
                  Routes.startWebView(context, {'url': data['url'], 'title': data['title']});
                },
              );
            }
          }
        } else {
          return Image.asset('res/images/bg.jpg', fit: BoxFit.cover);
        }
      },
    );
  }
}
