import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;
  final int _version = 1;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var _dir = await getDatabasesPath();
    String path = _dir + '/tog_test.db';

    var db = await openDatabase(
      path,
      version: _version,
      onCreate: _createDb,
      onUpgrade:
          _onUpgrade, /* (Database db, int version, int newVer) async {
      if (newVer == _version) _createDb(db, newVer);
    } */
    );
    return db;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE ${DBTableBiodata.TABLE}(${DBTableBiodata.COLUMN_NAMA} TEXT, ${DBTableBiodata.COLUMN_ALAMAT} TEXT, ${DBTableBiodata.COLUMN_TGL_LAHIR} TEXT, ${DBTableBiodata.COLUMN_TINGGI} INTEGER, ${DBTableBiodata.COLUMN_BERAT} INTEGER, ${DBTableBiodata.COLUMN_FOTO} TEXT, ${DBTableBiodata.COLUMN_CREATED_AT} REAL)');
    print('versi baru create: ' + newVersion.toString());
  }

  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      String sql =
          'CREATE TABLE ${DBTableBiodata.TABLE}(${DBTableBiodata.COLUMN_NAMA} TEXT, ${DBTableBiodata.COLUMN_ALAMAT} TEXT, ${DBTableBiodata.COLUMN_TGL_LAHIR} TEXT, ${DBTableBiodata.COLUMN_TINGGI} INTEGER, ${DBTableBiodata.COLUMN_BERAT} INTEGER, ${DBTableBiodata.COLUMN_FOTO} TEXT, ${DBTableBiodata.COLUMN_CREATED_AT} REAL)';
      print('upgrade \n $sql');
      db.execute(sql);
    }
    print('versi lama : ' + oldVersion.toString());
    print('versi baru : ' + newVersion.toString());
  }

  // User Log
  Future<List<Map<String, dynamic>>> get(String table,
      {Map<String, dynamic>? wheres,
      List<String>? columns,
      String option = ''}) async {
    Database db = await database;
    String where = "";

    if (wheres != null) {
      wheres.forEach((key, value) {
        where += (where == "") ? "$key = '$value'" : "AND $key = '$value'";
      });
    }

    String sql = "SELECT * FROM $table $where $option";

    var result = await db.rawQuery(sql);
    return result;
  }

  Future<int> delete(String table, {Map<String, dynamic>? wheres}) async {
    var db = await database;
    String where = "";

    if (wheres != null) {
      wheres.forEach((key, value) {
        where += (where == "") ? "$key = '$value'" : "AND $key = '$value'";
      });
    }

    int result = await db.rawDelete('DELETE FROM $table $where');
    return result;
  }

  Future<int> create(String table, Map<String, dynamic> values) async {
    Database db = await database;
    int id = await db.insert(table, values);

    return id;
  }
}

class DBTableBiodata {
  static const String TABLE = 'biodata';
  static const String COLUMN_NAMA = 'nama';
  static const String COLUMN_ALAMAT = 'alamat';
  static const String COLUMN_TGL_LAHIR = 'tgl_lahir';
  static const String COLUMN_TINGGI = 'tinggi';
  static const String COLUMN_BERAT = 'berat';
  static const String COLUMN_FOTO = 'foto';
  static const String COLUMN_CREATED_AT = 'created_at';
}
