import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SearchTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];
  final tQuery = 'Spiderman';

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTvShowRepository.searchTvShow(tQuery))
        .thenAnswer((_) async => Right(tTvShows));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvShows));
  });
}
