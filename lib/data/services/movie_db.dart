import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flash_chat_flutter/data/services/db.dart';
import 'package:flash_chat_flutter/data/models/movies_model.dart';
import 'package:flash_chat_flutter/data/models/movies_list/movies_list.dart';

class MovieDB {
  final String _apiKey = '442f08ed580949109afb21f8d78ec790';
  final String _url = 'api.themoviedb.org';
  Future<List<MoviesModel>> _getDBData() async {
    List _results = await DB.query(MoviesModel.table);
    return _results.map((item) => MoviesModel.fromMap(item)).toList();
  }

  Future<MoviesList> getMoviesList(VoidCallback errorFunction) async {
    var uri = Uri.https('$_url', '/3/movie/upcoming', {'api_key': _apiKey});
    try {
      var response = await get(uri);
      var dbData = await _getDBData();

      if (dbData.any((el) => el.name == 'movies')) {
        var item = dbData.firstWhere((el) => el.name == 'movies');
        item.jsonMoviesDBData = response.body;
        await DB.update(MoviesModel.table, item);
      } else {
        var item = MoviesModel(
          name: 'movies',
          jsonMoviesDBData: response.body,
        );
        await DB.insert(MoviesModel.table, item);
      }

      var moviesListData = MoviesList.fromJson(
          {'moviesList': json.decode(response.body)['results']});

      return moviesListData;
    } catch (e) {
      print(e);
      errorFunction();

      var dbData = await _getDBData();

      if (dbData.any((el) => el.name == 'movies')) {
        var movies = dbData.firstWhere((el) => el.name == 'movies');
        return MoviesList(json.decode(movies.jsonMoviesDBData)['results']);
      } else {
        return MoviesList([]);
      }
    }
  }

  void storeFavouriteMovies(List favouritesMovies) async {
    var dbData = await _getDBData();

    if (dbData.any((el) => el.name == 'favouritesMovies')) {
      var item = dbData.firstWhere((el) => el.name == 'favouritesMovies');
      item.jsonMoviesDBData = json.encode(favouritesMovies);
      await DB.update(MoviesModel.table, item);
    } else {
      var item = MoviesModel(
        name: 'favouritesMovies',
        jsonMoviesDBData: json.encode(favouritesMovies),
      );
      await DB.insert(MoviesModel.table, item);
    }
  }

  Future<MoviesList> getFavouriteMovies() async {
    var dbData = await _getDBData();

    if (dbData.any((el) => el.name == 'favouritesMovies')) {
      var movies = dbData.firstWhere(
        (el) => el.name == 'favouritesMovies',
      );

      var moviesListData = MoviesList.fromJson(
          {'moviesList': json.decode(movies.jsonMoviesDBData)});

      return moviesListData;
    } else {
      return MoviesList([]);
    }
  }
}
