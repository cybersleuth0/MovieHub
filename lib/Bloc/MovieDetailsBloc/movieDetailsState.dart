import '../../model/model.dart';

abstract class MovieDetailsState {}

class MovieDetailsInitial extends MovieDetailsState {}

class MovieDetailsLoading extends MovieDetailsState {}

class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;
  MovieDetailsErrorState({required this.errorMessage});
}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetailsModel movieDetails;
  MovieDetailsSuccessState(this.movieDetails);

}
