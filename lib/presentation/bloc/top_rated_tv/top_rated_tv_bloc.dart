import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_event.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv/top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTvShows _getTopRatedTvShows;

  TopRatedTvBloc(this._getTopRatedTvShows) : super(TopRatedListEmpty()) {
    on<GetTopRatedTvEvent>((event, emit) async {

      emit(TopRatedListLoading());
      final result = await _getTopRatedTvShows.execute();

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