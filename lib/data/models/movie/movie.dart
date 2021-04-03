import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
abstract class Movie with _$Movie {
  factory Movie(
    bool adult,
    String backdrop_path,
    int id,
    String original_language,
    String original_title,
    String overview,
    double popularity,
    String release_date,
    String title,
    double vote_average,
    int vote_count,
  ) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
