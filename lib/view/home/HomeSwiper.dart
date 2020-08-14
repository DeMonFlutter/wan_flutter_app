import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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

class HomeSwiperState extends State<HomeSwiper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RepResult>(
      future: HttpUtils.instance.getFuture("banner"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List bannerList = snapshot.data.data;
          if (snapshot.hasError || bannerList.isEmpty) {
            return Image.asset('res/images/bg.jpg', fit: BoxFit.cover);
          } else {
            return Swiper(
              itemBuilder: (context, index) {
                return new Image.network(bannerList[index]['imagePath'], fit: BoxFit.cover);
              },
              itemCount: bannerList.length,
              autoplay: bannerList.length > 1,
              autoplayDelay: 5000,
              pagination: SwiperPagination(),
            );
          }
        } else {
          return Image.asset('res/images/bg.jpg', fit: BoxFit.cover);
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
