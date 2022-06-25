import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_event.dart';
import 'package:ditonton/presentation/bloc/popular_tv/popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvShows _getPopularTvShows;

  PopularTvBloc(this._getPopularTvShows) : super(PopularListEmpty()) {
    on<GetPopularTvEvent>((event, emit) async {

      emit(PopularListLoading());
      final result = await _getPopularTvShows.execute();

      result.fold(
            (failure) {
          emit(PopularListError(failure.message));
        },
            (data) {
          emit(PopularListHasData(data));
        },
      );
    });
  }
}