import 'dart:convert';
import 'package:http/http.dart';
import 'package:flash_chat_flutter/services/db.dart';
import 'package:flash_chat_flutter/models/movies_model.dart';

class MovieDB {
  String _apiKey = '442f08ed580949109afb21f8d78ec790';
  String _url = 'https://api.themoviedb.org/3/movie/upcoming';
  Future<List<MoviesModel>> _getDBData() async {
    List _results = await DB.query(MoviesModel.table);
    return _results.map((item) => MoviesModel.fromMap(item)).toList();
  }

  Future getMoviesList() async {
    try {
      Response response = await get('$_url?api_key=$_apiKey');
      List<MoviesModel> dbData = await _getDBData();

      if (dbData.any((el) => el.name == 'movies')) {
        MoviesModel item = dbData.firstWhere((el) => el.name == 'movies');
        item.jsonMoviesDBData = response.body;
        await DB.update(MoviesModel.table, item);
      } else {
        MoviesModel item = MoviesModel(
          name: 'movies',
          jsonMoviesDBData: response.body,
        );
        await DB.insert(MoviesModel.table, item);
      }

      return json.decode(response.body)['results'];
    } catch (e) {
      print(e);

      List<MoviesModel> dbData = await _getDBData();

      if (dbData.any((el) => el.name == 'movies')) {
        MoviesModel movies =
            dbData.firstWhere((el) => el.name == 'movies', orElse: () {
          return null;
        });
        return json.decode(movies.jsonMoviesDBData)['results'];
      } else {
        return [];
      }
    }
  }

  storeFavouriteMovies(List favouritesMovies) async {
    List<MoviesModel> dbData = await _getDBData();

    if (dbData.any((el) => el.name == 'favouritesMovies')) {
      MoviesModel item =
          dbData.firstWhere((el) => el.name == 'favouritesMovies');
      item.jsonMoviesDBData = json.encode(favouritesMovies);
      await DB.update(MoviesModel.table, item);
    } else {
      MoviesModel item = MoviesModel(
        name: 'favouritesMovies',
        jsonMoviesDBData: json.encode(favouritesMovies),
      );
      await DB.insert(MoviesModel.table, item);
    }
  }

  Future getFavouriteMovies() async {
    List<MoviesModel> dbData = await _getDBData();

    if (dbData.any((el) => el.name == 'favouritesMovies')) {
      MoviesModel movies = dbData.firstWhere(
        (el) => el.name == 'favouritesMovies',
      );
      return json.decode(movies.jsonMoviesDBData);
    } else {
      return [];
    }
  }
}
