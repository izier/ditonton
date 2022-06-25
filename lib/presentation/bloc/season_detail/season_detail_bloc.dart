import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_event.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_state.dart';

class SeasonDetailBloc extends Bloc<SeasonDetailEvent, SeasonDetailState> {
  GetTvSeasonDetail _getTvSeasonDetail;

  SeasonDetailBloc(this._getTvSeasonDetail) : super(SeasonDetailEmpty()) {
    on<GetSeasonDetailEvent>((event, emit) async {
      emit(SeasonDetailLoading());
      final result = await _getTvSeasonDetail.execute(event.id, event.seasonNumber);

      result.fold(
            (failure) {
          emit(SeasonDetailError(failure.message));
        },
            (season) {
          emit(SeasonDetailHasData(season: season));
        },
      );
    });
  }
}