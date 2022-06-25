import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedListEmpty extends TopRatedTvState {}

class TopRatedListLoading extends TopRatedTvState {}

class TopRatedListError extends TopRatedTvState {
  final String message;

  TopRatedListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedListHasData extends TopRatedTvState {
  final List<TvShow> result;

  TopRatedListHasData(this.result);

  @override
  List<Object> get props => result;
}