import 'package:ditonton/data/models/tv_episode_model.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

class TvSeasonDetailResponse extends Equatable {
  TvSeasonDetailResponse({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodes
  });

  final int id;
  final String overview;
  final String name;
  final String posterPath;
  final int seasonNumber;
  final List<TvEpisodeModel> episodes;

  factory TvSeasonDetailResponse.fromJson(Map<String, dynamic> json) => TvSeasonDetailResponse(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
    episodes: List<TvEpisodeModel>.from(
        json["episodes"].map((x) => TvEpisodeModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "poster_path": posterPath,
    "name": name,
    "season_number": seasonNumber,
    "episodes": List<dynamic>.from(episodes.map((x) => x.toJson))
  };

  TvSeasonDetail toEntity() {
    return TvSeasonDetail(
        id: this.id,
        name: this.name,
        overview: this.overview,
        posterPath: this.posterPath,
        seasonNumber: this.seasonNumber,
        episodes: this.episodes.map((episode) => episode.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
    episodes,
  ];
}
