import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvShowDetail extends Equatable {
  TvShowDetail({
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
  final List<Genre> genres;
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
  final List<TvSeason> seasons;

  @override
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
