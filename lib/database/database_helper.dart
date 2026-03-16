import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'exercises.db');

    // ลบฐานข้อมูลเก่าในครั้งแรกเพราะต้องแก้เกี่ยวกับโครงสร้างตาราง
    //await deleteDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        muscle TEXT,
        sets INTEGER,
        currentSet INTEGER,
        reps INTEGER,
        currentRep INTEGER,
        isCompleted INTEGER,
        day TEXT,
        image TEXT,
        images TEXT,
        video TEXT
      )
      '''
    );
  }
}