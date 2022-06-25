import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

class NowPlayingListEmpty extends NowPlayingMoviesState {}

class NowPlayingListLoading extends NowPlayingMoviesState {}

class NowPlayingListError extends NowPlayingMoviesState {
  final String message;

  NowPlayingListError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingListHasData extends NowPlayingMoviesState {
  final List<Movie> result;

  NowPlayingListHasData(this.result);

  @override
  List<Object> get props => result;
}