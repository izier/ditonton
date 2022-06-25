import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_event.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies/now_playing_movies_state.dart';

class NowPlayingMoviesBloc extends Bloc<NowPlayingMoviesEvent, NowPlayingMoviesState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMoviesBloc(this._getNowPlayingMovies) : super(NowPlayingListEmpty()) {
    on<GetNowPlayingMoviesEvent>((event, emit) async {

      emit(NowPlayingListLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
            (failure) {
          emit(NowPlayingListError(failure.message));
        },
            (data) {
          emit(NowPlayingListHasData(data));
        },
      );
    });
  }
}