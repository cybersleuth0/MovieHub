abstract class MoviesEvent {}

class GetMoviesEvent extends MoviesEvent {}

class GetMoreMoviesEvent extends MoviesEvent {
  final int? pageNum;

  GetMoreMoviesEvent({this.pageNum});
}
