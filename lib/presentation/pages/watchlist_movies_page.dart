import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_tv_show_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
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
        Provider.of<WatchlistMovieNotifier>(context, listen: false)
            .fetchWatchlistMovies();
        Provider.of<WatchListTvShowNotifier>(context, listen: false)
            .fetchWatchlistTvShows();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchListTvShowNotifier>(context, listen: false)
        .fetchWatchlistTvShows();
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
                      child: Consumer<WatchlistMovieNotifier>(
                        builder: (context, data, child) {
                          if (data.watchlistState == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.watchlistState == RequestState.Loaded) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final movie = data.watchlistMovies[index];
                                return MovieCard(movie);
                              },
                              itemCount: data.watchlistMovies.length,
                            );
                          } else {
                            return Center(
                              key: Key('error_message'),
                              child: Text(data.message),
                            );
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
                      child: Consumer<WatchListTvShowNotifier>(
                        builder: (context, data, child) {
                          if (data.watchlistState == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (data.watchlistState == RequestState.Loaded) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                final tvShow = data.watchlistTvShow[index];
                                return TvShowCard(tvShow);
                              },
                              itemCount: data.watchlistTvShow.length,
                            );
                          } else {
                            return Center(
                              key: Key('error_message'),
                              child: Text(data.message),
                            );
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
