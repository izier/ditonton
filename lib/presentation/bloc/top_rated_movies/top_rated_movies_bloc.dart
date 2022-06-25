import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedListEmpty()) {
    on<GetTopRatedMoviesEvent>((event, emit) async {

      emit(TopRatedListLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
            (failure) {
          emit(TopRatedListError(failure.message));
        },
            (data) {
          emit(TopRatedListHasData(data));
        },
      );
    });
  }
}