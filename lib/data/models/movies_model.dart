class MoviesModel {
  static String table = 'movieDB_items';

  final int? id;
  final String name;
  String jsonMoviesDBData;

  MoviesModel({
    this.id,
    required this.name,
    required this.jsonMoviesDBData,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'jsonMoviesDBData': jsonMoviesDBData
    };

    map['id'] = id;
    return map;
  }

  static MoviesModel fromMap(Map<String, dynamic> map) {
    return MoviesModel(
        id: map['id'],
        name: map['name'],
        jsonMoviesDBData: map['jsonMoviesDBData']);
  }
}
