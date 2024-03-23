
import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DB {
  late Database _db;
  static int get _version => 1;

  Future<void> init() async {
    try {
      String path = await getDatabasesPath();
      String dbpath = p.join(path, 'database.db');
      _db = await openDatabase(dbpath, version: _version, onCreate: onCreate);
    } catch (ex) {
      print(ex);
    }
  }

  static FutureOr<void> onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries (
        id INTEGER PRIMARY KEY NOT NULL,
        date STRING, 
        duration STRING, 
        speed REAL, 
        distance REAL
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> query(String table) async =>
      await _db.query(table);
  Future<int> insert(String table, Entry item) async =>
      await _db.insert(table, item.toMap());
}

class Entry {
  static String table = "entries";

  int? id;
  String? date;
  String? duration;
  double? speed;
  double? distance;


  Entry({this.id, this.date, this.duration, this.speed, this.distance});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date,
      'duration': duration,
      'speed': speed,
      'distance': distance,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  static Entry fromMap(Map<String, dynamic> map) {
    return Entry(
        id: map['id'],
        date: map['date'],
        duration: map['duration'],
        speed: map['speed'],
        distance: map['distance']);
  }
}