import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:equatable/equatable.dart';

abstract class SeasonDetailState extends Equatable {
  SeasonDetailState();

  @override
  List<Object> get props => [];
}

class SeasonDetailEmpty extends SeasonDetailState {}

class SeasonDetailLoading extends SeasonDetailState {}

class SeasonDetailError extends SeasonDetailState {
  final String message;

  SeasonDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class SeasonDetailHasData extends SeasonDetailState {
  final TvSeasonDetail season;

  SeasonDetailHasData({required this.season});

  @override
  List<Object> get props => [season];
}