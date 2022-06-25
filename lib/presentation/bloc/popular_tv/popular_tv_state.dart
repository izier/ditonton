import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularListEmpty extends PopularTvState {}

class PopularListLoading extends PopularTvState {}

class PopularListError extends PopularTvState {
  final String message;

  PopularListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularListHasData extends PopularTvState {
  final List<TvShow> result;

  PopularListHasData(this.result);

  @override
  List<Object> get props => result;
}