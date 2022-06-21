import 'package:ditonton/domain/entities/tv_episode.dart';
import 'package:equatable/equatable.dart';

class TvEpisodeModel extends Equatable {
  TvEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodeNumber
  });

  final int id;
  final String overview;
  final String name;
  final int seasonNumber;
  final int episodeNumber;

  factory TvEpisodeModel.fromJson(Map<String, dynamic> json) => TvEpisodeModel(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    seasonNumber: json["season_number"],
    episodeNumber: json["episode_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "name": name,
    "season_number": seasonNumber,
    "episode_number": episodeNumber,
  };

  TvEpisode toEntity() {
    return TvEpisode(
        id: this.id,
        name: this.name,
        overview: this.overview,
        seasonNumber: this.seasonNumber,
        episodeNumber: this.episodeNumber,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    seasonNumber,
    episodeNumber,
  ];
}
