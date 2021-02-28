import 'dart:convert';
import 'package:http/http.dart';
import 'package:flash_chat_flutter/services/db.dart';
import 'package:flash_chat_flutter/models/movies_model.dart';

class MovieDB {
  String _apiKey = '442f08ed580949109afb21f8d78ec790';
  String _url = 'https://api.themoviedb.org/3/movie/upcoming';
  Future<List> _getDBData() async {
    return await DB.query(MoviesModel.table);
  }

  Future getMoviesList() async {
    try {
      Response response = await get('$_url?api_key=$_apiKey');
      MoviesModel item = MoviesModel(
        name: 'movies',
        jsonMoviesDBData: response.body,
      );

      List storedData = await _getDBData();
      if (storedData.any((el) => el['name'] == 'movies')) {
        await DB.update(MoviesModel.table, item);
      } else {
        await DB.insert(MoviesModel.table, item);
      }

      return json.decode(response.body)['results'];
    } catch (e) {
      print(e);

      List dbData = await _getDBData();

      if (dbData.any((el) => el['name'] == 'movies')) {
        Map movies =
            dbData.firstWhere((el) => el['name'] == 'movies', orElse: () {
          return null;
        });
        return json.decode(movies['jsonMoviesDBData'])['results'];
      } else {
        return [];
      }
    }
  }

  storeFavouriteMovies(List favouritesMovies) async {
    List dbData = await _getDBData();
    MoviesModel item = MoviesModel(
      name: 'favouritesMovies',
      jsonMoviesDBData: json.encode(favouritesMovies),
    );

    if (dbData.any((el) => el['name'] == 'favouritesMovies')) {
      await DB.update(MoviesModel.table, item);
    } else {
      await DB.insert(MoviesModel.table, item);
    }
  }

  Future getFavouriteMovies() async {
    List dbData = await _getDBData();

    if (dbData.any((el) => el['name'] == 'favouritesMovies')) {
      Map movies = dbData.firstWhere((el) => el['name'] == 'favouritesMovies');
      return json.decode(movies['jsonMoviesDBData']);
    } else {
      return [];
    }
  }
}
