import 'package:gojek_sederhana/app/data/models/send_good.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final _databaseName = "gojek_sederhana.db";
  static final _databaseVersion = 1;

  static final table = "sendgood";

  // static final columnId = 'id';
  // static final columnTitle = 'title';

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE sendgood(id INTEGER PRIMARY KEY, latDriver REAL, longDriver REAL, latOffice REAL, longOffice REAL, distance REAL, image TEXT, date TEXT)
          ''');

    await db.execute('''
          CREATE TABLE profile(id INTEGER PRIMARY KEY, name TEXT, password TEXT, image TEXT, nik INT)
          ''');
  }

  Future<int> insert(SendGood sg) async {
    Database db = await instance.database;
    var res = await db.insert(table, sg.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> getList() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "id DESC");
    return res;
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTable() async {
    Database db = await instance.database;
    await db.rawQuery("DELETE FROM $table");
  }
}
