import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tarea8/models/incident.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void initializeDatabase() {
  
  databaseFactory = databaseFactoryFfi;
}

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'incidents.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE incidents(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, description TEXT, photoPath TEXT, audioPath TEXT)",
        );
      },
    );
  }

  Future<void> insertIncident(Incident incident) async {
    final db = await database;
    await db.insert('incidents', incident.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Incident>> incidents() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('incidents');
    return List.generate(maps.length, (i) {
      return Incident(
        title: maps[i]['title'],
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description'],
        photoPath: maps[i]['photoPath'],
        audioPath: maps[i]['audioPath'],
      );
    });
  }

  Future<void> deleteAllIncidents() async {
    final db = await database;
    await db.delete('incidents');
  }
}


