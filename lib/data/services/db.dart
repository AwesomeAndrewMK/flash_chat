import 'dart:async';
import 'package:flash_chat_flutter/data/models/movies_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DB {
  static Database? _db;

  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }

    try {
      _db = await openDatabase(
        join((await getDatabasesPath())!, 'movies'),
        version: _version,
        onCreate: onCreate,
      );
    } catch (e) {
      print(e);
    }
  }

  static void onCreate(Database db, int version) async => await db.execute(
      'CREATE TABLE movieDB_items (id INTEGER PRIMARY KEY NOT NULL, name STRING, jsonMoviesDBData STRING)');

  static Future<List<Map<String, dynamic>>> query(String table) async =>
      _db!.query(table);

  static Future<int> insert(String table, MoviesModel model) async =>
      await _db!.insert(
        table,
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

  static Future<int> update(String table, MoviesModel model) async =>
      await _db!.update(
        table,
        model.toMap(),
        where: 'id = ?',
        whereArgs: [model.id],
      );

  static Future<int> delete(String table, MoviesModel model) async =>
      await _db!.delete(
        table,
        where: 'id = ?',
        whereArgs: [model.id],
      );
}
