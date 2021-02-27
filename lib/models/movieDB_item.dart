import 'moviesData_model.dart';

class MovieDBItem extends MoviesDataModel {
  static String table = 'movieDB_items';

  int id;
  String name;
  String jsonMoviesDBData;

  MovieDBItem({this.id, this.name, this.jsonMoviesDBData});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'jsonMoviesDBData': jsonMoviesDBData
    };

    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static MovieDBItem fromMap(Map<String, dynamic> map) {
    return MovieDBItem(
        id: map['id'],
        name: map['name'],
        jsonMoviesDBData: map['jsonMoviesDBData']);
  }
}
