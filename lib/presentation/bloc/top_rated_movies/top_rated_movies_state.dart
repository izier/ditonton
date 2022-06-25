import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

abstract class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object> get props => [];
}

class TopRatedListEmpty extends TopRatedMoviesState {}

class TopRatedListLoading extends TopRatedMoviesState {}

class TopRatedListError extends TopRatedMoviesState {
  final String message;

  TopRatedListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedListHasData extends TopRatedMoviesState {
  final List<Movie> result;

  TopRatedListHasData(this.result);

  @override
  List<Object> get props => result;
}