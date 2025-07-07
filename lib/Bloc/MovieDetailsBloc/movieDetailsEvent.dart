abstract class MovieDetailsEvent {}

class GetMovieDetailsEvent extends MovieDetailsEvent {
  int movieId;
  GetMovieDetailsEvent({required this.movieId});
}
