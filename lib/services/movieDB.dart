import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MovieDB {
  String _apiKey = '442f08ed580949109afb21f8d78ec790';

  _storeResponse(Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('movieDBRes', response.body);
  }

  _getStoredResponse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('movieDBRes');
  }

  Future getMoviesList() async {
    try {
      Response response = await get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey');
      await _storeResponse(response);
      return json.decode(response.body)['results'];
    } catch (e) {
      print(e);

      String storedRes = await _getStoredResponse();
      if (storedRes == null) {
        return null;
      } else {
        return json.decode(storedRes)['results'];
      }
    }
  }

  storeFavouriteMovies(List favouritesMovies) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('favouritesMovies', json.encode(favouritesMovies));
  }

  Future getFavouriteMovies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String favouritesMovies = prefs.getString('favouritesMovies');

    if (favouritesMovies == null) {
      return [];
    } else {
      return json.decode(favouritesMovies);
    }
  }
}
