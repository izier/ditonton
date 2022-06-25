import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class PopularMoviesState extends Equatable {
  const PopularMoviesState();

  @override
  List<Object> get props => [];
}

class PopularListEmpty extends PopularMoviesState {}

class PopularListLoading extends PopularMoviesState {}

class PopularListError extends PopularMoviesState {
  final String message;

  PopularListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularListHasData extends PopularMoviesState {
  final List<Movie> result;

  PopularListHasData(this.result);

  @override
  List<Object> get props => result;
}