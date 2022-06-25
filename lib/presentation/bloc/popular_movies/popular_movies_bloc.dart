import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_event.dart';
import 'package:ditonton/presentation/bloc/popular_movies/popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(PopularListEmpty()) {
    on<GetPopularMoviesEvent>((event, emit) async {

      emit(PopularListLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
            (failure) {
          emit(PopularListError(failure.message));
        },
            (data) {
          emit(PopularListHasData(data));
        },
      );
    });
  }
}