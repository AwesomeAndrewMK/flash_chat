import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flash_chat_flutter/data/services/db.dart';
import 'package:flash_chat_flutter/data/models/movies_model.dart';

class MovieDB {
  final String _apiKey = '442f08ed580949109afb21f8d78ec790';
  final String _url = 'api.themoviedb.org';
  Future<List<MoviesModel>> _getDBData() async {
    List _results = await DB.query(MoviesModel.table);
    return _results.map((item) => MoviesModel.fromMap(item)).toList();
  }

  Future getMoviesList(VoidCallback errorFunction) async {
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

      return json.decode(response.body)['results'];
    } catch (e) {
      print(e);
      errorFunction();

      var dbData = await _getDBData();

      if (dbData.any((el) => el.name == 'movies')) {
        var movies = dbData.firstWhere((el) => el.name == 'movies');
        return json.decode(movies.jsonMoviesDBData)['results'];
      } else {
        return [];
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

  Future getFavouriteMovies() async {
    var dbData = await _getDBData();

    if (dbData.any((el) => el.name == 'favouritesMovies')) {
      var movies = dbData.firstWhere(
        (el) => el.name == 'favouritesMovies',
      );
      return json.decode(movies.jsonMoviesDBData);
    } else {
      return [];
    }
  }
}
