import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class HandleMoviesList {
  final List<dynamic> moviesList;

  HandleMoviesList({
    @required this.moviesList,
  });

  String _formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMM y').format(parsedDate).toUpperCase();
  }

  int _findDiffInDays(String date) {
    DateTime now = DateTime.now();
    return now.difference(DateTime.parse(date)).inDays;
  }

  // can use it in case you want release date >= now
  bool isBiggerThanNow(String date) {
    return Timestamp.fromDate(DateTime.parse(date)).millisecondsSinceEpoch >=
        Timestamp.fromDate(DateTime.now()).millisecondsSinceEpoch;
  }

  Map<String, List<dynamic>> getGroupedMovies() {
    moviesList.sort((a, b) =>
        b['vote_average'].toDouble().compareTo(a['vote_average'].toDouble()));

    List data = moviesList
        .where((item) => _findDiffInDays(item['release_date']) < 90)
        .toList();

    Map<String, List<dynamic>> groupedMovies =
        groupBy(data, (item) => _formatDate(item['release_date']));

    return groupedMovies;
  }
}
