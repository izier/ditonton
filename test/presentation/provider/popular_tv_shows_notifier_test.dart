import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/presentation/provider/popular_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late MockGetPopularTvShows mockGetPopularTvShows;
  late PopularTvShowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvShows = MockGetPopularTvShows();
    notifier = PopularTvShowsNotifier(mockGetPopularTvShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  final tTvShowList = <TvShow>[tTvShow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
