import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieshub/AppConstant/urls.dart';
import 'package:movieshub/Bloc/movies_event.dart';
import 'package:movieshub/Bloc/movies_state.dart';
import 'package:movieshub/data/remote/helper/api_helper.dart';
import 'package:movieshub/model/model.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final ApiHelper apiHelper;
  int pageNum = 1;
  List<MovieModel> allMovies = [];
  bool _isLoading = false;

  MoviesBloc({required this.apiHelper}) : super(InitialState()) {
    on<GetMoviesEvent>((event, emit) async {
      if (_isLoading) return;
      _isLoading = true;

      emit(LoadingState());
      pageNum = 1;
      allMovies.clear();

      try {
        final response = await apiHelper.getApi(
          url: "${Urls.getTrendingMovies}&page=$pageNum",
        );
        if (response != null) {
          final movies = MovieResponseModel.fromJson(response).results;
          allMovies = movies;
          pageNum++;
          emit(HomepageInitailStae(trendingMovies: allMovies));
        } else {
          emit(ErrorState(errorMessage: "Failed to fetch movies"));
        }
      } catch (e) {
        emit(ErrorState(errorMessage: "Initial load failed: ${e.toString()}"));
      } finally {
        _isLoading = false;
      }
    });

    on<GetMoreMoviesEvent>((event, emit) async {
      if (_isLoading) return;
      _isLoading = true;
      emit(HomepageInitailStae(trendingMovies: allMovies, isLoadingMore: true));

      try {
        final response = await apiHelper.getApi(
          url: "${Urls.getTrendingMovies}&page=$pageNum",
        );

        if (response != null) {
          final newMovies = MovieResponseModel.fromJson(response).results;
          allMovies.addAll(newMovies);
          pageNum++;
          emit(HomepageInitailStae(trendingMovies: allMovies));
        } else {
          emit(ErrorState(errorMessage: "Failed to fetch more movies"));
        }
      } catch (e) {
        emit(HomepageInitailStae(trendingMovies: allMovies));
      } finally {
        _isLoading = false;
      }
    });
  }
}
