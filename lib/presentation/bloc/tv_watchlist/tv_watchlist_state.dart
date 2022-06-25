import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class TvWatchlistState extends Equatable {
  TvWatchlistState();

  @override
  List<Object> get props => [];

}

class TvWatchlistEmpty extends TvWatchlistState {}

class TvWatchlistLoading extends TvWatchlistState {}

class TvWatchlistError extends TvWatchlistState {
  final String message;

  TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistHasData extends TvWatchlistState {
  final List<TvShow> tvShows;

  TvWatchlistHasData({required this.tvShows});

  @override
  List<Object> get props => [tvShows];
}