import 'package:flutter/cupertino.dart';

import '../UIPages/homepage.dart';
import '../UIPages/splashScreen.dart';

class AppRoutes {
  static const String ROUTE_SPLASH_SCREEN = "/splashScreen";
  static const String ROUTE_HOME_SCREEN = "/homeScreen";

  Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_SPLASH_SCREEN: (context) => SplashScreen(),
    ROUTE_HOME_SCREEN:(context)=>HomeScreen(),
  };
}
