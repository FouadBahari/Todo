import 'dart:async';
import "dart:io" as io;
import 'package:flutter/widgets.dart';
import "package:path/path.dart";
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../models/task.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() {
    return _instance;
  }
  DBHelper._internal();

  static Database? _db;
  static const int _version = 1;
  static const String _tableName = 'tasks';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    debugPrint('db init');
    return _db!;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'task.db');

    var tasksDB =
        await openDatabase(path, version: _version, onCreate: _onCreate);
    return tasksDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_tableName ( '
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title STRING, '
      'note TEXT, '
      'isCompleted INTEGER, '
      'date STRING, '
      'startTime STRING, '
      'endTime STRING, '
      'color INTEGER, '
      'remind INTEGER, '
      'repeat STRING ) ',
    );
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    int id = await _db!.insert(_tableName, task!.toJson());
    debugPrint('$id');
    return id;
  }

  static Future<int> delete(Task? task) async {
    print('delete function called');
    return await _db!
        .delete(_tableName, where: 'id = ?', whereArgs: [task!.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await _db!.query(_tableName);
  }

  static Future<int> update(int? id) async {
    print('update function called');
    return await _db!.rawUpdate('''
        UPDATE tasks
        SET isCompleted = ?
        WHERE id = ?
        ''', [1, id!]);
  }
}
