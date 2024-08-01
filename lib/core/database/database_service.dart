import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:people_managment/core/constants/constants.dart' as c;
class DatabaseService{
  static Database? _database;
  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database=await _initialize();
    return _database!;
  }

  Future<String> get fullPath async{
    const name="${c.databaseName}.db";
    final path=await getDatabasesPath();
    return join(path,name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS ${c.tableNameGroup}(
      PK_${c.tableNameGroup}ID INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    )''');

    await database.execute('''CREATE TABLE IF NOT EXISTS ${c.tableNamePeople}(
      PK_${c.tableNamePeople}ID INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      surname TEXT,
      birthDate TEXT,
      postCode TEXT,
      city TEXT,
      street TEXT,
      county TEXT,
      voivodeship TEXT
    )''');

    await database.execute('''CREATE TABLE IF NOT EXISTS ${c.tableNamePeople}_${c.tableNameGroup}(
      FK_${c.tableNamePeople}ID INTEGER,
      FK_${c.tableNameGroup}ID INTEGER,
      FOREIGN KEY (FK_${c.tableNamePeople}ID) REFERENCES ${c.tableNamePeople} (PK_${c.tableNamePeople}ID) ON DELETE CASCADE,
      FOREIGN KEY (FK_${c.tableNameGroup}ID) REFERENCES ${c.tableNameGroup} (PK_${c.tableNameGroup}ID) ON DELETE CASCADE,
      PRIMARY KEY (FK_${c.tableNamePeople}ID, FK_${c.tableNameGroup}ID)
    )''');
  }


}