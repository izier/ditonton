import 'dart:convert';

import 'package:ditonton/data/datasources/tv_show_remote_data_source.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/models/tv_season_detail_model.dart';
import 'package:ditonton/data/models/tv_show_detail_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Airing Tv Show', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/now_airing.json')))
        .tvShowList;

    test('should return list of Tv Show Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/now_airing.json'), 200));
          // act
          final result = await dataSource.getNowAiringTvShows();
          // assert
          expect(result, equals(tTvShowList));
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getNowAiringTvShows();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Popular Tv Show', () {
    final tTvShowList =
        TvShowResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json')))
            .tvShowList;

    test('should return list of tv shows when response is success (200)',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));
          // act
          final result = await dataSource.getPopularTvShows();
          // assert
          expect(result, tTvShowList);
        });

    test(
        'should throw a ServerException when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getPopularTvShows();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get Top Rated Tv Shows', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json')))
        .tvShowList;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvShows();
      // assert
      expect(result, tTvShowList);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTopRatedTvShows();
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tv show detail', () {
    final tId = 1;
    final tTvShowDetail = TvShowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_detail.json')));

    test('should return tv show detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_show_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tTvShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvShowDetail(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get movie recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_recommendations.json')))
        .tvShowList;
    final tId = 1;

    test('should return list of Movie Model when the response code is 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_show_recommendations.json'), 200));
          // act
          final result = await dataSource.getTvShowRecommendations(tId);
          // assert
          expect(result, equals(tTvShowList));
        });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvShowRecommendations(tId);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('search tv show', () {
    final tSearchResult = TvShowResponse.fromJson(
        json.decode(readJson('dummy_data/search_spiderman_tv.json')))
        .tvShowList;
    final tQuery = 'Spiderman';

    test('should return list of tv shows when response code is 200', () async {
      // arrange
      when(mockHttpClient
          .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
          readJson('dummy_data/search_spiderman_tv.json'), 200));
      // act
      final result = await dataSource.searchTvShow(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
            () async {
          // arrange
          when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.searchTvShow(tQuery);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });

  group('get tv season detail', () {
    final tTvId = 1;
    final tSeasonNumber = 1;
    final tTvSeasonDetail = TvSeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_season_detail.json')));

    test('should return tv show detail when the response code is 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId/season/$tSeasonNumber?$API_KEY')))
          .thenAnswer((_) async =>
          http.Response(readJson('dummy_data/tv_season_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeasonDetail(tTvId, tSeasonNumber);
      // assert
      expect(result, equals(tTvSeasonDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
            () async {
          // arrange
          when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tTvId/season/$tSeasonNumber?$API_KEY')))
              .thenAnswer((_) async => http.Response('Not Found', 404));
          // act
          final call = dataSource.getTvSeasonDetail(tTvId, tSeasonNumber);
          // assert
          expect(() => call, throwsA(isA<ServerException>()));
        });
  });
}
