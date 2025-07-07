import '../../model/model.dart';

abstract class MoviesState {}

class InitialState extends MoviesState {}

class LoadingState extends MoviesState {}

class ErrorState extends MoviesState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

class HomepageInitailStae extends MoviesState {
  final List<MovieModel> trendingMovies;
  final bool isLoadingMore;


  HomepageInitailStae({
    required this.trendingMovies,
    this.isLoadingMore = false,
  });
}

