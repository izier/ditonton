import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  TvSeasonModel({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber
  });

  final int id;
  final String overview;
  final String name;
  final String posterPath;
  final int seasonNumber;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
    id: json["id"],
    name: json["name"],
    overview: json["overview"],
    posterPath: json["poster_path"],
    seasonNumber: json["season_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "overview": overview,
    "poster_path": posterPath,
    "name": name,
    "season_number": seasonNumber,
  };

  TvSeason toEntity() {
    return TvSeason(
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      seasonNumber: this.seasonNumber
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}
