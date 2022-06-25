import 'package:equatable/equatable.dart';

abstract class SeasonDetailEvent extends Equatable {
  const SeasonDetailEvent();

  @override
  List<Object> get props => [];
}

class GetSeasonDetailEvent extends SeasonDetailEvent {
  final int id;
  final int seasonNumber;

  GetSeasonDetailEvent({required this.id, required this.seasonNumber});

  @override
  List<Object> get props => [id];
}