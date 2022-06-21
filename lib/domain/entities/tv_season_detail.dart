import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetail extends Equatable {
  TvSeasonDetail({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodes
  });

  int id;
  String? overview;
  String? name;
  String posterPath;
  int? seasonNumber;
  List<TvEpisode> episodes;

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
    episodes
  ];
}