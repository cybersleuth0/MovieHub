import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieshub/AppConstant/constant.dart';
import 'package:movieshub/Bloc/MovieLoadBloc/movies_bloc.dart';

import 'Bloc/MovieDetailsBloc/movieDetailsBloc.dart';
import 'data/remote/helper/api_helper.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MoviesBloc(apiHelper: ApiHelper())),
        BlocProvider(
            create: (context) => MovieDetailsBloc(apiHelper: ApiHelper()))
      ],
      child: MaterialApp(
        initialRoute: AppRoutes.ROUTE_SPLASH_SCREEN,
        routes: AppRoutes().getRoutes(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
