import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  GetTvDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AddWatchlistEvent extends TvDetailEvent {
  final TvShowDetail tv;

  AddWatchlistEvent({required this.tv});

  @override
  List<Object> get props => [tv];
}

class RemoveWatchlistEvent extends TvDetailEvent {
  final TvShowDetail tv;

  RemoveWatchlistEvent({required this.tv});

  @override
  List<Object> get props => [tv];
}

class GetWatchlistStatusEvent extends TvDetailEvent {
  final int id;

  GetWatchlistStatusEvent({required this.id});

  @override
  List<Object> get props => [id];
}