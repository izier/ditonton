import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchListTvShows _getWatchListTvShows;

  TvWatchlistBloc(this._getWatchListTvShows) : super(TvWatchlistEmpty()) {
    on<GetTvWatchlistEvent>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await _getWatchListTvShows.execute();

      result.fold(
            (failure) {
          emit(TvWatchlistError(failure.message));
        },
            (tvShows) {
          emit(TvWatchlistHasData(tvShows: tvShows));
        },
      );
    });
  }
}