import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_shows.dart';
import 'package:flutter/foundation.dart';

class NowAiringTvShowsNotifier extends ChangeNotifier {
  final GetNowAiringTvShows getNowAiringTvShows;

  NowAiringTvShowsNotifier(this.getNowAiringTvShows);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvShow> _tvShows = [];
  List<TvShow> get tvShows => _tvShows;

  String _message = '';
  String get message => _message;

  Future<void> fetchNowAiringTvShows() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getNowAiringTvShows.execute();

    result.fold(
          (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
          (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
