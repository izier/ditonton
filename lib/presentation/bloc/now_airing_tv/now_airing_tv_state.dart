import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class NowAiringTvState extends Equatable {
  const NowAiringTvState();

  @override
  List<Object> get props => [];
}

class NowAiringListEmpty extends NowAiringTvState {}

class NowAiringListLoading extends NowAiringTvState {}

class NowAiringListError extends NowAiringTvState {
  final String message;

  NowAiringListError(this.message);

  @override
  List<Object> get props => [message];
}

class NowAiringListHasData extends NowAiringTvState {
  final List<TvShow> result;

  NowAiringListHasData(this.result);

  @override
  List<Object> get props => result;
}