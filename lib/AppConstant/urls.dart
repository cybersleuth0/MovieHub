class Urls {
  static const String apiKey = "26ea08d001679772eed03e2213f26244";
  static const String moviesDB = "https://api.themoviedb.org/3";
  static const String getPosterImage = "https://image.tmdb.org/t/p/w185";
  static const String getTrendingMovies = "$moviesDB/trending/movie/day?language=en-US&api_key=$apiKey";
  static const String SearchMovie =
      "$moviesDB/search/movie?query=kgf&include_adult=false&language=en-US&api_key=$apiKey&page=1";
  static const String getMovieDetails = "$moviesDB/movie/";
}
