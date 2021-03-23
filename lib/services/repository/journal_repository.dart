import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class JournalRepository {
  static final _dbName = "journals.db";
  static final _dbVersion = 1;
  static final _table = "journals";
  static final _columnImages = "images";
  static final _columnId = "id";
  static final _columnBody = "body";
  static final _columnDate = "date";

  JournalRepository._dbInstance();

  static final JournalRepository instance = JournalRepository._dbInstance();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_table (
    $_columnId INTEGER PRIMARY KEY,
    $_columnBody TEXT NOT NULL,
    $_columnDate INTEGER NOT NULL,
    $_columnImages STRING )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var database = await instance.database;

    return await database.insert(_table, row);
  }

  Future<List<Map<String, dynamic>>> all() async {
    Database db = await instance.database;
    return await db.query(_table, orderBy: "date desc");
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[_columnId];
    return await db
        .update(_table, row, where: '$_columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(_table, where: '$_columnId = ?', whereArgs: [id]);
  }
}
