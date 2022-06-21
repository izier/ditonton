// Mocks generated by Mockito 5.2.0 from annotations
// in ditonton/test/presentation/provider/tv_show_list_notifier_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:ditonton/common/failure.dart' as _i6;
import 'package:ditonton/domain/entities/tv_show.dart' as _i7;
import 'package:ditonton/domain/repositories/tv_show_repository.dart' as _i2;
import 'package:ditonton/domain/usecases/get_now_airing_tv_shows.dart' as _i4;
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart' as _i8;
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart' as _i9;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeTvShowRepository_0 extends _i1.Fake implements _i2.TvShowRepository {
}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

/// A class which mocks [GetNowAiringTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowAiringTvShows extends _i1.Mock
    implements _i4.GetNowAiringTvShows {
  MockGetNowAiringTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetPopularTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvShows extends _i1.Mock implements _i8.GetPopularTvShows {
  MockGetPopularTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}

/// A class which mocks [GetTopRatedTvShows].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTvShows extends _i1.Mock
    implements _i9.GetTopRatedTvShows {
  MockGetTopRatedTvShows() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TvShowRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvShowRepository_0()) as _i2.TvShowRepository);
  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
          returnValue: Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>.value(
              _FakeEither_1<_i6.Failure, List<_i7.TvShow>>())) as _i5
          .Future<_i3.Either<_i6.Failure, List<_i7.TvShow>>>);
}