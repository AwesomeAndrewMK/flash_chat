import 'dart:convert';
import 'package:http/http.dart';
import 'package:flash_chat_flutter/services/db.dart';
import 'package:flash_chat_flutter/models/movieDB_item.dart';

class MovieDB {
  String _apiKey = '442f08ed580949109afb21f8d78ec790';

  Future getMoviesList() async {
    try {
      Response response = await get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey');

      MovieDBItem item =
          MovieDBItem(name: 'movies', jsonMoviesDBData: response.body);

      await DB.insert(MovieDBItem.table, item);
      return json.decode(response.body)['results'];
    } catch (e) {
      print(e);

      List storedData = await DB.query(MovieDBItem.table);
      var movies =
          storedData.firstWhere((el) => el['name'] == 'movies', orElse: () {
        return null;
      });

      if (movies == null) {
        return [];
      } else {
        return json.decode(movies['jsonMoviesDBData'])['results'];
      }
    }
  }

  storeFavouriteMovies(List favouritesMovies) async {
    MovieDBItem item = MovieDBItem(
      name: 'favouritesMovies',
      jsonMoviesDBData: json.encode(favouritesMovies),
    );

    await DB.insert(MovieDBItem.table, item);
  }

  Future getFavouriteMovies() async {
    List storedData = await DB.query(MovieDBItem.table);
    var favouritesMovies = storedData
        .firstWhere((el) => el['name'] == 'favouritesMovies', orElse: () {
      return null;
    });

    if (favouritesMovies == null) {
      return [];
    } else {
      return json.decode(favouritesMovies['jsonMoviesDBData']);
    }
  }
}
