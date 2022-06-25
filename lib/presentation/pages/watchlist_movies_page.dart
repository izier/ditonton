import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist/movie_watchlist_state.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_event.dart';
import 'package:ditonton/presentation/bloc/tv_watchlist/tv_watchlist_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
        Provider.of<MovieWatchlistBloc>(context, listen: false)
            .add(GetMovieWatchlistEvent());
        Provider.of<TvWatchlistBloc>(context, listen: false)
            .add(GetTvWatchlistEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<MovieWatchlistBloc>(context, listen: false)
        .add(GetMovieWatchlistEvent());
    Provider.of<TvWatchlistBloc>(context, listen: false)
        .add(GetTvWatchlistEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text('Movies', style: kHeading6)
                    ),
                    Expanded(
                      child: BlocBuilder<MovieWatchlistBloc, MovieWatchlistState>(
                        builder: (context, state) {
                          if (state is MovieWatchlistLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is MovieWatchlistHasData) {
                            if (state.movies.isEmpty) {
                              return Center(child: Text('You haven\'t added any movies'));
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final movie = state.movies[index];
                                  return MovieCard(movie);
                                },
                                itemCount: state.movies.length,
                              );
                            }
                          } else if (state is MovieWatchlistError){
                            return Center(
                              key: Key('error_message'),
                              child: Text(state.message),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                )
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Text('TV Shows', style: kHeading6)
                    ),
                    Expanded(
                      child: BlocBuilder<TvWatchlistBloc, TvWatchlistState>(
                        builder: (context, state) {
                          if (state is TvWatchlistLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is TvWatchlistHasData) {
                            if (state.tvShows.isEmpty) {
                              return Center(child: Text('You haven\'t added any TV shows'));
                            } else {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final tvShow = state.tvShows[index];
                                  return TvShowCard(tvShow);
                                },
                                itemCount: state.tvShows.length,
                              );
                            }
                          } else if (state is TvWatchlistError){
                            return Center(
                              key: Key('error_message'),
                              child: Text(state.message),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
