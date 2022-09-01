import 'package:firebase_storage/firebase_storage.dart';
import 'package:sqflite/sqflite.dart';

import '../../Model/local_storage_donation_model.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "donations";
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = "${await getDatabasesPath()}tasks.db";
      _db = await openDatabase(_path, version: _version,
          onCreate: (db, version) async {
        print("creating a new one");
        return await db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, description TEXT,pickup STRING, itemName STRING,category STRING,quantity STRING,attachement STRING,itemDescription STRING,date STRING,status STRING)');
      });
    } catch (e) {
      print(e);
    }
  }

  // insert Method
  static Future<int> insert(LocalDonation? doantion) async {
    print("insert function is called");
    return await _db?.insert(_tableName, doantion!.toJson()) ?? 1;
  }

  // read Method
  static Future<List<Map<String, Object?>>?> readData() async {
    print("read function is called");
    return await _db?.query(_tableName);
  }

  // delete Method
  static Future<int?> delete({required LocalDonation task}) async {
    print("delete function is called");
    return await _db?.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static Future<int?> updateData(
      {required LocalDonation task, required int id}) async {
    print("*************************UPDATING ID IS *************************");
    print(
        "*************************${task.id} ${id} *************************");
    print("*************************UPDATING ID IS *************************");
    return await _db!.rawUpdate('''
    UPDATE $_tableName 
    SET itemName = ?, category = ? , quantity = ?, description = ? , attachement = ?
    WHERE id = ?
    ''', [
      task.itemName,
      task.category,
      task.quantity,
      task.description,
      task.attachement,
      id,
    ]);
  }

  static Future<int?> update(
      {required LocalDonation task, required int id}) async {
    return await _db!.rawUpdate('''
    UPDATE $_tableName 
    SET category = ${task.category} 
    WHERE id = $id 
    ''');
  }

  static Future<int?> deleteAll() async {
    return await _db!.rawDelete('''
  delete from $_tableName
    ''');

    //   rawUpdate('''
    // delete from $_tableName
    //   ''');
  }

  // update Method

}
