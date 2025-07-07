import 'package:flutter_bloc/flutter_bloc.dart';

import '../../AppConstant/urls.dart';
import '../../data/remote/helper/api_helper.dart';
import '../../model/model.dart';
import '../MovieLoadBloc/movies_event.dart';
import 'movieDetailsEvent.dart';
import 'movieDetailsState.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final ApiHelper apiHelper;

  MovieDetailsBloc({required this.apiHelper}) : super(MovieDetailsInitial()) {
    on<GetMovieDetailsEvent>((event, emit) async {
      emit(MovieDetailsLoading());
      try {
        final response = await apiHelper.getApi(
          url: "${Urls.getMovieDetails}${event.movieId}?api_key=${Urls.apiKey}",
        );
        if (response != null) {
          final movie = MovieDetailsModel.fromJson(response);
          emit(MovieDetailsSuccessState(movie));
        } else {
          emit(MovieDetailsErrorState(errorMessage: "Failed to load details"));
        }
      } catch (e) {
        emit(MovieDetailsErrorState(errorMessage: "Failed to Load Details"));
      }
    });
  }
}
