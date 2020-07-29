import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Routes.dart';
import 'model/ColorModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ColorModel()),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ColorModel model = Provider.of<ColorModel>(context);
    model.change();
    return MaterialApp(
        title: "WanFlutter",
        routes: Routes.routes,
        initialRoute: "/",
        theme: ThemeData(
          primaryColor: model.themeColor,
          primaryColorDark: model.themeColorDark,
          accentColor: model.accentColor,
          iconTheme: IconThemeData(color: model.themeColor),
        ));
  }
}
