import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_season_model.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowDetailResponse extends Equatable {
  TvShowDetailResponse({
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.status,
    required this.tagline,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.numberOfSeasons,
    required this.numberOfEpisodes,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.seasons
  });

  final String? backdropPath;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String name;
  final double voteAverage;
  final int voteCount;
  final int numberOfSeasons;
  final int numberOfEpisodes;
  final String firstAirDate;
  final String? lastAirDate;
  final List<TvSeasonModel> seasons;

  factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvShowDetailResponse(
        backdropPath: json["backdrop_path"],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        firstAirDate: json["first_air_date"],
        lastAirDate: json["last_air_date"],
        status: json["status"],
        tagline: json["tagline"],
        name: json["name"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        numberOfSeasons: json["number_of_seasons"],
        numberOfEpisodes: json["number_of_episodes"],
        seasons: List<TvSeasonModel>.from(
            json["seasons"].map((x) => TvSeasonModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "original_language": originalLanguage,
    "original_name": originalName,
    "first_air_date": firstAirDate,
    "last_air_date": lastAirDate,
    "number_of_seasons": numberOfSeasons,
    "number_of_episodes": numberOfEpisodes,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "status": status,
    "tagline": tagline,
    "name": name,
    "vote_average": voteAverage,
    "vote_count": voteCount,
    "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
  };

  TvShowDetail toEntity() {
    return TvShowDetail(
      backdropPath: this.backdropPath,
      genres: this.genres.map((genre) => genre.toEntity()).toList(),
      homepage: this.homepage,
      originalLanguage: this.originalLanguage,
      originalName: this.originalName,
      name: this.name,
      numberOfSeasons: this.numberOfSeasons,
      numberOfEpisodes: this.numberOfEpisodes,
      firstAirDate: this.firstAirDate,
      lastAirDate: this.lastAirDate,
      id: this.id,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
      voteCount: this.voteCount,
      popularity: this.popularity,
      status: this.status,
      tagline: this.tagline,
      seasons: this.seasons.map((season) => season.toEntity()).toList(),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    backdropPath,
    genres,
    homepage,
    id,
    originalLanguage,
    overview,
    popularity,
    posterPath,
    status,
    tagline,
    originalName,
    name,
    firstAirDate,
    lastAirDate,
    numberOfSeasons,
    numberOfEpisodes,
    voteAverage,
    voteCount,
    seasons,
  ];
}
