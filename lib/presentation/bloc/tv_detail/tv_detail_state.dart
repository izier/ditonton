import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailState extends Equatable {
  TvDetailState();

  @override
  List<Object> get props => [];

}

class TvDetailEmpty extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class TvDetailHasData extends TvDetailState {
  final TvShowDetail tv;
  final List<TvShow> recommendations;
  final bool status;

  TvDetailHasData({required this.tv, required this.recommendations, required this.status});

  @override
  List<Object> get props => [tv, recommendations, status];
}

class WatchlistSuccess extends TvDetailState {
  final String message;

  WatchlistSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class WatchlistError extends TvDetailState {
  final String message;

  WatchlistError({required this.message});

  @override
  List<Object> get props => [message];
}

class WatchlistStatusState extends TvDetailState {
  final bool status;

  WatchlistStatusState({required this.status});

  @override
  List<Object> get props => [status];
}