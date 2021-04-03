// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoviesList _$_$_MoviesListFromJson(Map<String, dynamic> json) {
  return _$_MoviesList(
    (json['moviesList'] as List<dynamic>)
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_MoviesListToJson(_$_MoviesList instance) =>
    <String, dynamic>{
      'moviesList': instance.moviesList,
    };
