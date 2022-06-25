import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_event.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_state.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'season_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeasonDetail])
void main() {
  late SeasonDetailBloc tvSeasonDetailBloc;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;

  setUp(() {
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    tvSeasonDetailBloc = SeasonDetailBloc(mockGetTvSeasonDetail);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tTvSeason = TvSeasonDetail(
    seasonNumber: 1,
    episodes: [],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'title',
  );

  test('initial state should be empty', () {
    expect(tvSeasonDetailBloc.state, SeasonDetailEmpty());
  });

  group('Get Season Detail', () {

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'Shoud emit SeasonDetailLoading and SeasonDetailHasData when get Season Detail succeeded',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Right(tTvSeason));
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.add(GetSeasonDetailEvent(id: tId, seasonNumber: tSeasonNumber)),
      expect: () => [SeasonDetailLoading(), SeasonDetailHasData(season: tTvSeason)],
      verify: (_) {
        verify(mockGetTvSeasonDetail.execute(tId, tSeasonNumber));
      },
    );

    blocTest<SeasonDetailBloc, SeasonDetailState>(
      'Shoud emit SeasonDetailLoading and SeasonDetailError when Get SeasonDetail Failed',
      build: () {
        when(mockGetTvSeasonDetail.execute(tId, tSeasonNumber))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        return tvSeasonDetailBloc;
      },
      act: (bloc) => bloc.add(GetSeasonDetailEvent(id: tId, seasonNumber: tSeasonNumber)),
      expect: () => [SeasonDetailLoading(), SeasonDetailError('Failed')],
      verify: (_) {
        verify(mockGetTvSeasonDetail.execute(tId, tSeasonNumber));
      },
    );
  });
}