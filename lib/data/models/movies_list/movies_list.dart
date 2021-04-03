import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flash_chat_flutter/data/models/movie/movie.dart';

part 'movies_list.freezed.dart';
part 'movies_list.g.dart';

@freezed
abstract class MoviesList with _$MoviesList {
  factory MoviesList(
    List<Movie> moviesList,
  ) = _MoviesList;

  factory MoviesList.fromJson(Map<String, dynamic> json) =>
      _$MoviesListFromJson(json);
}
