import 'package:ditonton/presentation/bloc/now_airing_tv/now_airing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv/now_airing_tv_event.dart';
import 'package:ditonton/presentation/bloc/now_airing_tv/now_airing_tv_state.dart';
import 'package:ditonton/presentation/widgets/tv_show_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        Provider.of<NowAiringTvBloc>(context, listen: false)
            .add(GetNowAiringTvEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Airing Tv Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<NowAiringTvBloc, NowAiringTvState>(
          builder: (context, state) {
            if (state is NowAiringListEmpty) {
            }
            if (state is NowAiringListLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowAiringListHasData) {
              final result = state.result;
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final tvShow = result[index];
                  return TvShowCard(tvShow);
                },
                itemCount: result.length,
              );
            } else if (state is NowAiringListError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
