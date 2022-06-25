import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_event.dart';
import 'package:ditonton/presentation/bloc/tv_detail/tv_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'Tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetTvShowWatchlistStatus,
  SaveTvShowWatchList,
  RemoveTvShowWatchlist,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvShowDetail mockGetTvDetail;
  late MockGetTvShowRecommendations mockGetTvRecommendations;
  late MockGetTvShowWatchlistStatus mockGetWatchlistStatus;
  late MockSaveTvShowWatchList mockSaveWatchlist;
  late MockRemoveTvShowWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvShowDetail();
    mockGetTvRecommendations = MockGetTvShowRecommendations();
    mockGetWatchlistStatus = MockGetTvShowWatchlistStatus();
    mockSaveWatchlist = MockSaveTvShowWatchList();
    mockRemoveWatchlist = MockRemoveTvShowWatchlist();
    tvDetailBloc = TvDetailBloc(
        mockGetTvDetail,
        mockGetTvRecommendations,
        mockGetWatchlistStatus,
        mockSaveWatchlist,
        mockRemoveWatchlist
    );
  });

  final tId = 1;
  final tTv = TvShow(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvs = <TvShow>[tTv];

  final tTvDetail = TvShowDetail(
    backdropPath: 'backdropPath',
    genres: [Genre(id: 1, name: 'Comedy')],
    id: 1,
    originalName: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    name: 'title',
    voteAverage: 1,
    voteCount: 1,
    tagline: 'tagline',
    homepage: 'homepage',
    originalLanguage: 'originalLanguage',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    firstAirDate: 'firstAirDate',
    lastAirDate: 'lastAirDate',
    seasons: [],
    popularity: 1,
    status: 'status'
  );

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  group('Get Tv Detail', () {

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailLoading and TvDetailHasData when get Detail Tvs and Recommendation Succeed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(id: tId)),
      expect: () => [TvDetailLoading(), TvDetailHasData(tv: tTvDetail, recommendations: tTvs, status: false)],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailLoading and TvDetailError when Get TvRecommendations Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(tTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(id: tId)),
      expect: () => [TvDetailLoading(), TvDetailError('Failed')],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit TvDetailError when Get Tv Detail Failed',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ConnectionFailure('Failed')));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tTvs));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(id: tId)),
      expect: () => [TvDetailLoading(), TvDetailError('Failed')],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
        verify(mockGetWatchlistStatus.execute(tId));
      },
    );
  });

  group('AddToWatchlist Tv', () {

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit WatchlistSuccess and isAddedToWatchlist True when AddWatchlist Succeed',
      build: () {
        when(mockSaveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(AddWatchlistEvent(tv: tTvDetail)),
      expect: () => [WatchlistSuccess(message: 'Added to Watchlist'), WatchlistStatusState(status: true)],
      verify: (_) {
        verify(mockSaveWatchlist.execute(tTvDetail));
        verify(mockGetWatchlistStatus.execute(tTvDetail.id));
      },
    );
  });

  group('RemoveFromWatchlist Tv', () {

    blocTest<TvDetailBloc, TvDetailState>(
      'Shoud emit WatchlistMessage and isAddedToWatchlist False when Success RemoveFromWatchlist',
      build: () {
        when(mockRemoveWatchlist.execute(tTvDetail))
            .thenAnswer((_) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistEvent(tv: tTvDetail)),
      expect: () => [WatchlistSuccess(message: 'Removed from Watchlist'), WatchlistStatusState(status: false)],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(tTvDetail));
        verify(mockGetWatchlistStatus.execute(tTvDetail.id));
      },
    );
  });
}