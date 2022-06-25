import 'package:equatable/equatable.dart';

abstract class NowPlayingMoviesEvent extends Equatable {
  const NowPlayingMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMoviesEvent extends NowPlayingMoviesEvent {

  @override
  List<Object> get props => [];
}