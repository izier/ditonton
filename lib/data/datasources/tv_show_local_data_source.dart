import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertTvWatchList(TvShowTable tvShow);
  Future<String> removeTvWatchList(TvShowTable tvShow);
  Future<TvShowTable?> getTvShowById(int id);
  Future<List<TvShowTable>> getTvWatchList();
}

class TvShowLocalDataSourceImpl implements TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTvWatchList(TvShowTable tvShow) async {
    try {
      await databaseHelper.insertTvWatchList(tvShow);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvWatchList(TvShowTable tvShow) async {
    try {
      await databaseHelper.removeTvWatchList(tvShow);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvShowTable>> getTvWatchList() async {
    final result = await databaseHelper.getTvWatchList();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }
}
