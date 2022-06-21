import 'package:equatable/equatable.dart';

class TvEpisode extends Equatable {
  TvEpisode({
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber,
    required this.episodeNumber,
  });

  int id;
  String? overview;
  String name;
  int seasonNumber;
  int episodeNumber;

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    seasonNumber,
    episodeNumber
  ];
}