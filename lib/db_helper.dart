import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:daily_mistakes/models/mistake.dart';

final String tableName = 'Mistake';

class DBHelper {

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MistakesDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            name TEXT,
            colour TEXT,
            alertPeriod TEXT,
            count INTEGER,
            countTime TEXT,
            countTimeList TEXT,
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  //create
  createData(Mistake mistake) async {
    final db = await database;
    var res = await db.insert("Mistake", mistake.toMap());
    return res;
  }
  //delete
  deleteData(Mistake mistake) async {
    final db = await database;
    db.delete("Mistake", where: "id = ?", whereArgs: [mistake.id]);
  }
  //read
  getData(int id) async {
    final db  = await database;
    var res = await db.query("Mistake", where: "id = ? ", whereArgs: [id]);
    return res.isNotEmpty ? Mistake.fromMap(res.first) : null;
  }
  //read all
  getAllData() async {
    final db = await database;
    var res = await db.query("Mistake");
    List<Mistake> list = res.isNotEmpty ? res.map((c) => Mistake.fromMap(c)).toList() : [];
    return list;
  }

  //update
  updateData(Mistake mistake) async {
    final db = await database;
    var res = await db.update("Mistake", mistake.toMap(), where: "id = ?", whereArgs: [mistake.id]);
    return res;
  }


}

