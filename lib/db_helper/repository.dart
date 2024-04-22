// lib/db_helper/repository.dart

import 'package:untitled1/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;

  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  Future<int> insertData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection!.insert(table, data);
  }

  readData(String table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  Future<List<Map<String, dynamic>>> readDataById(String table, int itemId) async {
    var connection = await database;
    return await connection!.query(table, where: 'id = ?', whereArgs: [itemId]);
  }

  updateData(String table, Map<String, dynamic> data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'id=?', whereArgs: [data['id']]);
  }

  deleteDataById(String table, int itemId) async {
    var connection = await database;
    return await connection?.rawDelete("delete from $table where id=$itemId");
  }
}