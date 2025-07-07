class MovieResponseModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  MovieResponseModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> map) {
    return MovieResponseModel(
      page: map['page'],
      results: List<MovieModel>.from(
        map['results'].map((x) => MovieModel.fromJson(x)),
      ),
      totalPages: map['total_pages'],
      totalResults: map['total_results'],
    );
  }
}

class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
    );
  }
}

class MovieDetailsModel {
  final bool adult;
  final int budget;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String releaseDate;
  final String posterPath;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;

  MovieDetailsModel({
    required this.adult,
    required this.budget,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.title,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailsModel(
      adult: json['adult'] ?? false,
      budget: json['budget'] ?? 0,
      posterPath: json['poster_path'] ?? '',
      originalLanguage: json['original_language'] ?? '',
      overview: json['overview'] ?? '',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? '',
      revenue: json['revenue'] ?? 0,
      runtime: json['runtime'] ?? 0,
      status: json['status'] ?? '',
      tagline: json['tagline'] ?? '',
      title: json['title'] ?? '',
    );
  }
}
