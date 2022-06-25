import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_now_airing_tv_shows.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv/now_airing_tv_event.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv/now_airing_tv_state.dart';

class NowAiringTvBloc extends Bloc<NowAiringTvEvent, NowAiringTvState> {
  final GetNowAiringTvShows _getNowAiringTvShows;

  NowAiringTvBloc(this._getNowAiringTvShows) : super(NowAiringListEmpty()) {
    on<GetNowAiringTvEvent>((event, emit) async {

      emit(NowAiringListLoading());
      final result = await _getNowAiringTvShows.execute();

      result.fold(
            (failure) {
          emit(NowAiringListError(failure.message));
        },
            (data) {
          emit(NowAiringListHasData(data));
        },
      );
    });
  }
}