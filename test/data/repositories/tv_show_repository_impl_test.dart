import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/repositories/tv_show_repository_impl.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTvShowModel = TvShowModel(
      backdropPath: 'a',
      genreIds: [1],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      name: 'name',
      voteAverage: 1,
      voteCount: 1
  );

  final tTvShow = TvShow(
      backdropPath: 'a',
      genreIds: [1],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      name: 'name',
      voteAverage: 1,
      voteCount: 1
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Airing Tv Shows', () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowAiringTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // act
          final result = await repository.getNowAiringTvShows();
          // assert
          verify(mockRemoteDataSource.getNowAiringTvShows());
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowAiringTvShows())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowAiringTvShows();
          // assert
          verify(mockRemoteDataSource.getNowAiringTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowAiringTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowAiringTvShows();
          // assert
          verify(mockRemoteDataSource.getNowAiringTvShows());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Shows', () {
    test('should return tv show list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // act
          final result = await repository.getPopularTvShows();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(ServerException());
          // act
          final result = await repository.getPopularTvShows();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvShows();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Shows', () {
    test('should return tv show list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenAnswer((_) async => tTvShowModelList);
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(ServerException());
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TvShow Detail', () {
    final tId = 1;
    final tTvShowResponse = TvShowDetailResponse(
      backdropPath: 'backdropPath',
      genres: [GenreModel(id: 1, name: 'Action')],
      id: 1,
      originalName: 'originalTitle',
      overview: 'overview',
      posterPath: 'posterPath',
      name: 'title',
      voteAverage: 1,
      voteCount: 1,
      firstAirDate: 'firstAirDate',
      lastAirDate: 'lastAirDate',
      originalLanguage: '',
      homepage: '',
      numberOfEpisodes: 1,
      numberOfSeasons: 1,
      popularity: 1,
      seasons: [],
      status: 'status',
      tagline: '',
    );

    test(
        'should return tv show data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenAnswer((_) async => tTvShowResponse);
          // act
          final result = await repository.getTvShowDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result, equals(Right(testTvShowDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvShowDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvShowDetail(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Show Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    final tId = 1;

    test('should return data (tv show list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenAnswer((_) async => tTvShowList);
          // act
          final result = await repository.getTvShowRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(tTvShowList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvShowRecommendations(tId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvShowRecommendations(tId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Seach Tv Shows', () {
    final tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShow(tQuery))
              .thenAnswer((_) async => tTvShowModelList);
          // act
          final result = await repository.searchTvShow(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, tTvShowList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShow(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvShow(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShow(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvShow(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTvWatchList(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTvWatchList(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTvWatchList(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTvWatchList(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvShowById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv shows', () {
    test('should return list of Tv Shows', () async {
      // arrange
      when(mockLocalDataSource.getTvWatchList())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getTvWatchList();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchListTvShow]);
    });
  });
}
