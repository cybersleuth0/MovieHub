import 'package:flutter/cupertino.dart';
import '../UIPages/homepage.dart';
import '../UIPages/movieDetails.dart';
import '../UIPages/splashScreen.dart';

class AppRoutes {
  static const String ROUTE_SPLASH_SCREEN = "/splashScreen";
  static const String ROUTE_HOME_SCREEN = "/homeScreen";
  static const String ROUTE_MOVIE_DETAILS = "/movieDetails";

  Map<String, WidgetBuilder> getRoutes() => {
    ROUTE_SPLASH_SCREEN: (context) => SplashScreen(),
    ROUTE_HOME_SCREEN:(context)=>HomeScreen(),
    ROUTE_MOVIE_DETAILS: (context) => MovieDetailsPage()
  };
}
