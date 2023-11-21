import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInit {
  static final DatabaseInit _instance = DatabaseInit._internal();
  Database? _database;

  factory DatabaseInit() {
    return _instance;
  }

  DatabaseInit._internal();

  Future<Database> get database async{
    _database ??= await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'peep.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  static Future _onCreate(Database db, int version) async {

    // category table 생성
    await db.execute(
      """
      CREATE TABLE category(
          id INTEGER PRIMARY KEY,
          name TEXT,
          color TEXT,
          emoji TEXT,
          pos INTEGER)
      """,
    );

    // reminder table 생성
    await db.execute(
      """
      CREATE TABLE reminder(
          id INTEGER PRIMARY KEY,
          name TEXT,
          icon TEXT,
          if_condition TEXT,
          notify_condition TEXT,
          pos INTEGER)
      """,
    );

    // routine table 생성
    await db.execute(
      """
      CREATE TABLE routine(
          id INTEGER PRIMARY KEY,
          category_id INTEGER,
          reminder_id INTEGER,
          name TEXT,
          is_active INTEGER,
          priority INTEGER,
          repeat_condition TEXT,
          subtodo TEXT,
          pos INTEGER,
          FOREIGN KEY (category_id) REFERENCES category(id),
          FOREIGN KEY (reminder_id) REFERENCES reminder(id))
      """,
    );

    // _todo table 생성
    await db.execute(
      """
      CREATE TABLE todo(
          id INTEGER PRIMARY KEY,
          category_id INTEGER,
          reminder_id INTEGER,
          name TEXT,
          subtodo TEXT,
          date INTEGER,
          priority INTEGER,
          memo TEXT,
          is_checked INTEGER,
          is_fold INTEGER,
          pos INTEGER,
          FOREIGN KEY (category_id) REFERENCES category(id))
      """,
    );

    // subtodo table 생성
    await db.execute(
      """
      CREATE TABLE subtodo(
          id INTEGER PRIMARY KEY,
          todo_id INTEGER,
          name TEXT,
          is_checked INTEGER,
          pos INTEGER,
          FOREIGN KEY (todo_id) REFERENCES todo(id))
      """
    );
  }
}
