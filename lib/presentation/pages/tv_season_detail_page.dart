import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/tv_season_detail.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_event.dart';
import 'package:ditonton/presentation/bloc/season_detail/season_detail_state.dart';
import 'package:ditonton/presentation/widgets/tv_episode_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class TvSeasonDetailPage extends StatefulWidget {
  static const ROUTE_NAME = 'season/detail';

  final int tvId;
  final int seasonNumber;
  final String name;

  TvSeasonDetailPage({required this.tvId, required this.seasonNumber, required this.name});

  @override
  _TvSeasonDetailPageState createState() => _TvSeasonDetailPageState();
}

class _TvSeasonDetailPageState extends State<TvSeasonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<SeasonDetailBloc>(context, listen: false)
          .add(GetSeasonDetailEvent(id: widget.tvId, seasonNumber: widget.seasonNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeasonDetailBloc, SeasonDetailState>(
        builder: (context, state) {
          if (state is SeasonDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeasonDetailHasData) {
            final tvSeason = state.season;
            return SafeArea(
              child: DetailContent(
                tvSeason,
                widget.name
              ),
            );
          } else if (state is SeasonDetailError){
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeasonDetail tvSeason;
  final String name;
  DetailContent(this.tvSeason, this.name);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeason.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: kHeading6,
                            ),
                            Text(
                              tvSeason.name ?? '-',
                              style: kHeading5,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Episodes',
                              style: kHeading6,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height/2,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (context, index) {
                                  final episode = tvSeason.episodes[index];
                                  return TvEpisodeCard(episode, tvSeason.posterPath);
                                },
                                itemCount: tvSeason.episodes.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

}
