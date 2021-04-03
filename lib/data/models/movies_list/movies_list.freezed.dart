// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'movies_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MoviesList _$MoviesListFromJson(Map<String, dynamic> json) {
  return _MoviesList.fromJson(json);
}

/// @nodoc
class _$MoviesListTearOff {
  const _$MoviesListTearOff();

  _MoviesList call(List<Movie> moviesList) {
    return _MoviesList(
      moviesList,
    );
  }

  MoviesList fromJson(Map<String, Object> json) {
    return MoviesList.fromJson(json);
  }
}

/// @nodoc
const $MoviesList = _$MoviesListTearOff();

/// @nodoc
mixin _$MoviesList {
  List<Movie> get moviesList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MoviesListCopyWith<MoviesList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MoviesListCopyWith<$Res> {
  factory $MoviesListCopyWith(
          MoviesList value, $Res Function(MoviesList) then) =
      _$MoviesListCopyWithImpl<$Res>;
  $Res call({List<Movie> moviesList});
}

/// @nodoc
class _$MoviesListCopyWithImpl<$Res> implements $MoviesListCopyWith<$Res> {
  _$MoviesListCopyWithImpl(this._value, this._then);

  final MoviesList _value;
  // ignore: unused_field
  final $Res Function(MoviesList) _then;

  @override
  $Res call({
    Object? moviesList = freezed,
  }) {
    return _then(_value.copyWith(
      moviesList: moviesList == freezed
          ? _value.moviesList
          : moviesList // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

/// @nodoc
abstract class _$MoviesListCopyWith<$Res> implements $MoviesListCopyWith<$Res> {
  factory _$MoviesListCopyWith(
          _MoviesList value, $Res Function(_MoviesList) then) =
      __$MoviesListCopyWithImpl<$Res>;
  @override
  $Res call({List<Movie> moviesList});
}

/// @nodoc
class __$MoviesListCopyWithImpl<$Res> extends _$MoviesListCopyWithImpl<$Res>
    implements _$MoviesListCopyWith<$Res> {
  __$MoviesListCopyWithImpl(
      _MoviesList _value, $Res Function(_MoviesList) _then)
      : super(_value, (v) => _then(v as _MoviesList));

  @override
  _MoviesList get _value => super._value as _MoviesList;

  @override
  $Res call({
    Object? moviesList = freezed,
  }) {
    return _then(_MoviesList(
      moviesList == freezed
          ? _value.moviesList
          : moviesList // ignore: cast_nullable_to_non_nullable
              as List<Movie>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_MoviesList implements _MoviesList {
  _$_MoviesList(this.moviesList);

  factory _$_MoviesList.fromJson(Map<String, dynamic> json) =>
      _$_$_MoviesListFromJson(json);

  @override
  final List<Movie> moviesList;

  @override
  String toString() {
    return 'MoviesList(moviesList: $moviesList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MoviesList &&
            (identical(other.moviesList, moviesList) ||
                const DeepCollectionEquality()
                    .equals(other.moviesList, moviesList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(moviesList);

  @JsonKey(ignore: true)
  @override
  _$MoviesListCopyWith<_MoviesList> get copyWith =>
      __$MoviesListCopyWithImpl<_MoviesList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MoviesListToJson(this);
  }
}

abstract class _MoviesList implements MoviesList {
  factory _MoviesList(List<Movie> moviesList) = _$_MoviesList;

  factory _MoviesList.fromJson(Map<String, dynamic> json) =
      _$_MoviesList.fromJson;

  @override
  List<Movie> get moviesList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MoviesListCopyWith<_MoviesList> get copyWith =>
      throw _privateConstructorUsedError;
}
