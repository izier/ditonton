import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvShows usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetPopularTvShows(mockTvShowRepository);
  });

  final tTvShows = <TvShow>[];

  group('GetPopularTvShows Tests', () {
    group('execute', () {
      test(
          'should get list of tv shows from the repository when execute function is called',
              () async {
            // arrange
            when(mockTvShowRepository.getPopularTvShows())
                .thenAnswer((_) async => Right(tTvShows));
            // act
            final result = await usecase.execute();
            // assert
            expect(result, Right(tTvShows));
          });
    });
  });
}
