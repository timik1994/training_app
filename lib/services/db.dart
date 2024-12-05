import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../domain/models/bodyVolume.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(dbPath, "training_app.db"),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE IF NOT EXISTS bodyVolume(id INTEGER PRIMARY KEY, date TEXT, weight TEXT, biceps_volume TEXT, "
                "chest_volume TEXT, waist_volume TEXT, hip_volume TEXT, calves_volume TEXT)");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS exercisesStatistic(id INTEGER PRIMARY KEY, date TEXT UNIQUE, cardio INTEGER, "
                "press INTEGER, power INTEGER)");
      },

      onOpen: (db) async {
        /*await db.execute(
            "CREATE TABLE IF NOT EXISTS userInfo(GUID TEXT, username TEXT, login TEXT, opo_role TEXT, opo_pred_id INTEGER, has_admin_role TEXT, opo_id INTEGER, uid INTEGER, exp INTEGER)");*/

      },
      onUpgrade: (db, oldVersion, version) async {
        switch (oldVersion) {
          case 1:

            continue v2;
          v2:
          //case v2:
          // шаблон для новой версии
          //   continue v20;
          // v20:
          // case 20:
          default:
        }
      },

      // Текущая версия должна указывать на последний пустой кейс
      // (либо следующий за ним, что эквивалентно попаданию в default)
      version: 1,
    );
  }


  Future<int> insert(String tableName, Map<String, dynamic> values,
      {ConflictAlgorithm conflictAlgorithm = ConflictAlgorithm.replace}) async {
    final Database? db = await database;

    return db!.insert(
      tableName,
      values,
      conflictAlgorithm: conflictAlgorithm,
    );
  }


  Future<List<Map<String, dynamic>>> selectAll(String tableName) async {
    // Get a reference to the database.
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return maps;
  }



  Future<Map<String, dynamic>?> selectById(String tableName, int id) async {
    // Get a reference to the database.
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
    return (maps.length > 0) ? maps[0] : null;
  }


  Future<Map<String, dynamic>?> selectLastRecord() async {
    String tableName = 'bodyVolume';

    // Get a reference to the database.
    final Database? db = await database;

    List<Map<String, dynamic>> maps = await db!.query(
      tableName,
      orderBy: 'date DESC',
      limit: 1, // Запрашиваем только одну запись
    );

    if (maps.isNotEmpty) {
      return maps[0];
    } else {
      return null;
    }
  }


  Future<List<Map<String, dynamic>>> select(String tableName,
      { bool ?distinct,
        List<String> ?columns,
        String ?where,
        List<dynamic> ?whereArgs,
        String ?groupBy,
        String ?having,
        String ?orderBy,
        int ?limit,
        int ?offset}) async {
    // Get a reference to the database.
    final Database? db = await database;

    final List<Map<String, dynamic>> maps = await db!.query(tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset);
    return maps;
  }

  Future<int?> getTableLength(String tableName) async {
    Database db = await openDatabase(tableName);
    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
    return count;
  }


  Future<int> update(String tableName, Map<String, dynamic> values) async {
    // Get a reference to the database.
    final Database? db = await database;
    return db!.update(
      tableName,
      values,
      where: "id = ?",
      whereArgs: [values["id"]],
    );
  }


  Future<int> delete(String tableName, int id) async {
    final Database? db = await database;

    return db!.delete(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteAll(String tableName) async {
    // Get a reference to the database.
    final Database? db = await database;
    await db!.delete(tableName);
  }

  Future<Batch> get batch async {
    final Database? db = await database;
    return db!.batch();
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query, [List ? arguments]) async {
    final Database? db = await database;
    return db!.rawQuery(query, arguments);
  }

  static Future<List<Map<String, dynamic>>> getDataFromTable(String tableName) async {
    return _database!.query(tableName);
  }
}
