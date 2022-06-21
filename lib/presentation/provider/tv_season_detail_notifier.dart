import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailNotifier({
    required this.getTvSeasonDetail
  });

  late TvSeasonDetail _tvSeason;
  TvSeasonDetail get tvSeason => _tvSeason;

  RequestState _tvSeasonState = RequestState.Empty;
  RequestState get tvSeasonState => _tvSeasonState;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int tvId, int seasonNumber) async {
    _tvSeasonState = RequestState.Loading;
    notifyListeners();

    final detailResult = await getTvSeasonDetail.execute(tvId, seasonNumber);
    detailResult.fold(
      (failure) {
        _tvSeasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeason) {
        _tvSeason = tvSeason;
        _tvSeasonState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
