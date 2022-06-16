import 'package:database_project/data/local/models/local_data_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataServices {
  static Database? _database;
  final _databaseName = "table1.db";
  final _databaseVersion = 1;
  final table = "table2";
  final columnId = 'id';
  final columnValue = 'value';
  final columnLength = 'length';

  LocalDataServices.createInstance();
  static final LocalDataServices instance = LocalDataServices.createInstance();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnValue TEXT NOT NULL,
    $columnLength INTEGER NOT NULL
  )
  ''');
  }

  Future<int?> insert(LocalDataModel model) async {
    Database? db = await instance.database;
    var res = await db!.insert(table, model.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database? db = await instance.database;
    var res = await db!.query(
      table, /* orderBy: "$columnId DESC"*/
    );
    return res;
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database? db = await instance.database;
    return await db!.rawQuery("DELETE FROM $table");
  }
}
