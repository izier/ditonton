import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:flutter/foundation.dart';

class WatchListTvShowNotifier extends ChangeNotifier {
  var _watchListTvShow = <TvShow>[];
  List<TvShow> get watchlistTvShow => _watchListTvShow;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchListTvShowNotifier({required this.getWatchListTvShows});

  final GetWatchListTvShows getWatchListTvShows;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchListTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.Loaded;
        _watchListTvShow = tvShowsData;
        notifyListeners();
      },
    );
  }
}
