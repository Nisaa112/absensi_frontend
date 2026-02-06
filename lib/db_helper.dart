import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// Import semua model
import 'package:aplikasi_absensi/model/user_model.dart' as userModel;
import 'package:aplikasi_absensi/model/kelas_model.dart';
import 'package:aplikasi_absensi/model/guru_model.dart';
import 'package:aplikasi_absensi/model/siswa_,model.dart' show siswaModel;
import 'package:aplikasi_absensi/model/mapel_model.dart';
import 'package:aplikasi_absensi/model/jadwal_model.dart';

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
    // Tabel Users
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

    // Tabel Kelas
    await db.execute('''
      CREATE TABLE kelas (
        id INTEGER PRIMARY KEY,
        nama_kelas TEXT
      )
    ''');

    // Tabel Guru
    await db.execute('''
      CREATE TABLE guru (
        id INTEGER PRIMARY KEY,
        nama_guru TEXT,
        nip TEXT
      )
    ''');

    // Tabel Siswa
    await db.execute('''
      CREATE TABLE siswa (
        id INTEGER PRIMARY KEY,
        nama_siswa TEXT,
        nisn TEXT
      )
    ''');

    // Tabel Mapel
    await db.execute('''
      CREATE TABLE mapel (
        id INTEGER PRIMARY KEY,
        nama_mapel TEXT
      )
    ''');

    // Tabel Jadwal
    await db.execute('''
      CREATE TABLE jadwal (
        id INTEGER PRIMARY KEY,
        kelas_id INTEGER,
        mapel_id INTEGER,
        guru_id INTEGER,
        hari TEXT,
        jam_mulai TEXT,
        jam_selesai TEXT
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

  // --------------------------------------------------------------------------
  // --- FUNGSI CRUD MASTER DATA (KELAS, GURU, SISWA, MAPEL) ---
  // --------------------------------------------------------------------------

  // KELAS
  Future<List<kelasModel>> getAllKelas() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('kelas');
    return maps.map((json) => kelasModel.fromJson(json)).toList();
  }

  Future<int> insertKelas(kelasModel kelas) async {
    Database db = await instance.database;
    return await db.insert('kelas', kelas.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> clearKelasTable() async {
    Database db = await instance.database;
    return await db.delete('kelas');
  }

  // GURU
  Future<List<guruModel>> getAllGuru() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('guru');
    return maps.map((json) => guruModel.fromJson(json)).toList();
  }

  Future<int> insertGuru(guruModel guru) async {
    Database db = await instance.database;
    return await db.insert('guru', guru.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // SISWA
  Future<List<siswaModel>> getAllSiswa() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('siswa');
    return maps.map((json) => siswaModel.fromJson(json)).toList();
  }

  Future<int> insertSiswa(siswaModel siswa) async {
    Database db = await instance.database;
    return await db.insert('siswa', siswa.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // MAPEL
  Future<List<mapelModel>> getAllMapel() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('mapel');
    return maps.map((json) => mapelModel.fromJson(json)).toList();
  }

  Future<int> insertMapel(mapelModel mapel) async {
    Database db = await instance.database;
    return await db.insert('mapel', mapel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // --------------------------------------------------------------------------
  // --- FUNGSI CRUD JADWAL ---
  // --------------------------------------------------------------------------

  Future<List<jadwalModel>> getAllJadwal() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('jadwal');
    return maps.map((json) => jadwalModel.fromJson(json)).toList();
  }

  Future<int> insertJadwal(jadwalModel jadwal) async {
    Database db = await instance.database;
    return await db.insert('jadwal', jadwal.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> clearJadwalTable() async {
    Database db = await instance.database;
    return await db.delete('jadwal');
  }

  // --------------------------------------------------------------------------
  // --- UTILITY ---
  // --------------------------------------------------------------------------

  Future close() async {
    Database db = await instance.database;
    db.close();
  }
}