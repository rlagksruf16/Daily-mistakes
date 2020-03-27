import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Mistake{
  String name; //실수 카드 수정하려면 final을 지워야 해서 final 삭제.
  int id;
  Color colour;
  String alertPeriod;
  int count;
  var countTime;
  List countTimeList = List();
  List countTest = List();

  Mistake({this.name, this.id, this.colour, this.alertPeriod='하루에 1번', this.count = 0, this.countTime});

  void firstMistakeTime(){
    countTimeList.add(countTime);
    countTest.add(countTime);
  }

  void countUp(){
    count += 1;
    countTimeList.add(countTime);
    countTest.add(countTime);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'colour': colour,
      'alertPeriod': alertPeriod,
      'count': count,
      'countTimeList': countTimeList,
    };
  }
}


// DB 

final String TableName = 'Mistake';


// class DBHelper {
//   DBHelper._();
//   static final DBHelper _db = DBHelper._();
//   factory DBHelper() => _db;

//   static Database _database;

//   Future<Database> get database async {
//     if(_database != null )
//       return _database;
    
//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'MistakeDB.db');

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//           CREATE TABLE $TableName(
//             name TEXT,
//             id 
//             colour TEXT,
//             alert_period TEXT,
//             count INT,
//             count_time_list TEXT,
//           )
//           ''');
//       },
//       onUpgrade: (db, oldVersion, newVersion) {}
//     );
//   }

//   //Create
//   createData(Mistake mistake) async {
//     final db = await database;
//     var res = await db.rawInsert('INSERT INTO $TableName(name) VALUES(?)', [mistake.name]);
//     return res;
//   }
//   //Delete
//   deleteMistake(Text name) async {
//     final db = await database;
//     var res = db.rawDelete('DELETE FROM $TableName Where name = ?',[name]);
//     return res;
//   }
  
//   //Read
//   // getMistake(Text name) async{
//   //   final db = await database;
//   //   var res = await db.rawQuery('SELECT * FROM $TableName WHERE name = ?', [name]);
//   //   return res.isNotEmpty ? Mistake(name: res.first['name'], colour: res.first['color'])
//   // }

//   //Update
//   updateMistake(Mistake mistake) async {
//     final db = await database;
//     var res = db.rawUpdate('UPDATE $TableName SET name = ? WHERE = ?', [mistake.name, mistake.name]);
//     return res;
//   }


// }

