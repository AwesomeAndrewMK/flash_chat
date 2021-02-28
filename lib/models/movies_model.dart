class MoviesModel {
  static String table = 'movieDB_items';

  final int id;
  final String name;
  String jsonMoviesDBData;

  MoviesModel({this.id, this.name, this.jsonMoviesDBData});

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

  static MoviesModel fromMap(Map<String, dynamic> map) {
    return MoviesModel(
        id: map['id'],
        name: map['name'],
        jsonMoviesDBData: map['jsonMoviesDBData']);
  }
}
