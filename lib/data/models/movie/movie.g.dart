// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Movie _$_$_MovieFromJson(Map<String, dynamic> json) {
  return _$_Movie(
    json['adult'] as bool,
    json['backdrop_path'] as String,
    json['id'] as int,
    json['original_language'] as String,
    json['original_title'] as String,
    json['overview'] as String,
    (json['popularity'] as num).toDouble(),
    json['release_date'] as String,
    json['title'] as String,
    (json['vote_average'] as num).toDouble(),
    json['vote_count'] as int,
  );
}

Map<String, dynamic> _$_$_MovieToJson(_$_Movie instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'id': instance.id,
      'original_language': instance.original_language,
      'original_title': instance.original_title,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'release_date': instance.release_date,
      'title': instance.title,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
    };
