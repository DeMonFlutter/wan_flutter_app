import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wan_flutter_app/data/Const.dart';
import 'package:wan_flutter_app/model/ColorModel.dart';
import 'package:wan_flutter_app/utils/SPUtils.dart';
import 'package:wan_flutter_app/widget/CenterScaffold.dart';

/// @author DeMon
/// Created on 2020/4/23.
/// E-mail 757454343@qq.com
/// Desc:
///
class SettingThemePage extends StatefulWidget {
  @override
  createState() => new SettingThemePageState();
}

class SettingThemePageState extends State<SettingThemePage> {
  List<String> colorStr = ["永恒蓝(默认)", "健康绿", "天空蓝", "少女粉", "激情红", "幸运橙", "温暖橙", "魅力紫", "诱惑紫", "蓝靛青", "清新青", "茶叶绿", "琥珀黄", "活力黄"];

  ColorModel model;

  Widget _buildColors(int i) {
    return InputChip(
      selected: themeMode == i,
      padding: EdgeInsets.all(5),
      labelPadding: EdgeInsets.all(3),
      label: Text(
        colorStr[i],
        style: TextStyle(color: ColorModel.themeColors[i][0]),
      ),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: CircleAvatar(
        backgroundColor: ColorModel.themeColors[i][0],
      ),
      selectedColor: Colors.orangeAccent.withAlpha(88),
      selectedShadowColor: Colors.blue,
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      onSelected: (bool value) {
        setState(() {
          themeMode = i;
        });
        Future.value(SPUtils.setData(Const.THEME_MODE, themeMode)).then((bool) {
          model?.change();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<ColorModel>(context);
    return CenterScaffold(
      "设置主题颜色",
      <Widget>[
        GridView.builder(
          padding: EdgeInsets.only(bottom: 50, top: 50),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            childAspectRatio: 1 / 0.2,
          ),
          itemCount: ColorModel.themeColors.length,
          itemBuilder: (context, i) => _buildColors(i),
        )
      ],
      alignment: Alignment.topCenter,
    );
  }
}
