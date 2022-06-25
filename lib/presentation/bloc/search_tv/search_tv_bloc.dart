import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/search_tv/search_tv_event.dart';
import 'package:ditonton/presentation/bloc/search_tv/search_tv_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTvShows _searchTvShows;

  SearchTvBloc(this._searchTvShows) : super(SearchEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;

      emit(SearchLoading());
      final result = await _searchTvShows.execute(query);

      result.fold(
            (failure) {
          emit(SearchError(failure.message));
        },
            (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}