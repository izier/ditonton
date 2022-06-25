import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();

  @override
  List<Object> get props => [];
}

class SearchEmpty extends SearchTvState {}

class SearchLoading extends SearchTvState {}

class SearchError extends SearchTvState {
  final String message;

  SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends SearchTvState {
  final List<TvShow> result;

  SearchHasData(this.result);

  @override
  List<Object> get props => result;
}