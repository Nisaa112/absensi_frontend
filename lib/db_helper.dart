import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;

class DatabaseHelper {
  static final _databaseName = "AbsensiLokal.db";
  static final _databaseVersion = 1; 

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion, 
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        serial_number TEXT,
        role TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');
  }

  // --------------------------------------------------------------------------
  // --- FUNGSI CRUD USER ---
  // --------------------------------------------------------------------------

  Future<List<userModel.Data>> getAllUsers() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return userModel.Data.fromJson(maps[i]);
    });
  }

  Future<int> insertUser(userModel.Data user) async {
    Database db = await instance.database;
    return await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace, 
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> clearUserTable() async {
    Database db = await instance.database;
    return await db.delete('users');
  }

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}