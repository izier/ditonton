import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:ditonton/presentation/provider/tv_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_season_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvSeasonDetail,
])
void main() {
  late TvSeasonDetailNotifier provider;
  late MockGetTvSeasonDetail mockGetTvSeasonDetail;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeasonDetail = MockGetTvSeasonDetail();
    provider = TvSeasonDetailNotifier(
      getTvSeasonDetail: mockGetTvSeasonDetail
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTvId = 1;
  final tSeasonNumber = 1;

  void _arrangeUsecase() {
    when(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTvSeasonDetail));
  }

  group('Get Tv Season Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      verify(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv season when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.Loaded);
      expect(provider.tvSeason, testTvSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeasonDetail.execute(tTvId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(provider.tvSeasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
