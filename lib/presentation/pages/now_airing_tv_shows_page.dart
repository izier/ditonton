import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/now_airing_tv_shows_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowAiringTvShowsPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-airing-tv-shows';

  @override
  _NowAiringTvShowsPageState createState() => _NowAiringTvShowsPageState();
}

class _NowAiringTvShowsPageState extends State<NowAiringTvShowsPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<NowAiringTvShowsNotifier>(context, listen: false)
            .fetchNowAiringTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Airing Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NowAiringTvShowsNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = data.tvShows[index];
                  return TvShowCard(tvShow);
                },
                itemCount: data.tvShows.length,
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
    );
  }
}
