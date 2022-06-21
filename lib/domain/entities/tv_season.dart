import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  TvSeason({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.seasonNumber
  });

  int id;
  String overview;
  String name;
  String posterPath;
  int seasonNumber;

  @override
  List<Object?> get props => [
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}