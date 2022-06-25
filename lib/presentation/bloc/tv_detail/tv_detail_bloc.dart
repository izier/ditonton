import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvShowDetail _getTvDetail;
  final GetTvShowRecommendations _getTvRecommendations;
  final GetTvShowWatchlistStatus _getWatchListStatus;
  final SaveTvShowWatchList _saveWatchlist;
  final RemoveTvShowWatchlist _removeWatchlist;

  TvDetailBloc(this._getTvDetail, this._getTvRecommendations, this._getWatchListStatus, this._saveWatchlist, this._removeWatchlist) : super(TvDetailEmpty()) {
    on<GetTvDetailEvent>((event, emit) async {
      emit(TvDetailLoading());
      final result = await _getTvDetail.execute(event.id);
      final recommendations = await _getTvRecommendations.execute(event.id);
      final status = await _getWatchListStatus.execute(event.id);

      result.fold(
            (failure) {
          emit(TvDetailError(failure.message));
        },
            (tv) {
          recommendations.fold(
                  (failure) {
                emit(TvDetailError(failure.message));
              },
                  (recommendations) {
                emit(TvDetailHasData(tv: tv, recommendations: recommendations, status: status));
              }
          );
        },
      );
    });

    on<AddWatchlistEvent>((event, emit) async {
      final result = await _saveWatchlist.execute(event.tv);

      result.fold(
              (failure) {
            emit(WatchlistError(message: failure.message));
          },
              (success) {
            emit(WatchlistSuccess(message: success));
          }
      );

      add(GetWatchlistStatusEvent(id: event.tv.id));
    });

    on<RemoveWatchlistEvent>((event, emit) async {
      final result = await _removeWatchlist.execute(event.tv);

      result.fold(
              (failure) {
            emit(WatchlistError(message: failure.message));
          },
              (success) {
            emit(WatchlistSuccess(message: success));
          }
      );

      add(GetWatchlistStatusEvent(id: event.tv.id));
    });

    on<GetWatchlistStatusEvent>((event, emit) async{
      final status = await _getWatchListStatus.execute(event.id);
      emit(WatchlistStatusState(status: status));
    });
  }
}