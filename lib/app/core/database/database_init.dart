import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseInit {
  static final DatabaseInit _instance = DatabaseInit._internal();
  Database? _database;

  factory DatabaseInit() {
    return _instance;
  }

  DatabaseInit._internal();

  Future<Database> get database async {
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
          id TEXT PRIMARY KEY,
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
          id TEXT PRIMARY KEY,
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
          id TEXT PRIMARY KEY,
          category_id TEXT,
          reminder_id TEXT,
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
          id TEXT PRIMARY KEY,
          category_id TEXT,
          reminder_id TEXT,
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
    await db.execute("""
      CREATE TABLE subtodo(
          id TEXT PRIMARY KEY,
          todo_id TEXT,
          name TEXT,
          is_checked INTEGER,
          pos INTEGER,
          FOREIGN KEY (todo_id) REFERENCES todo(id))
      """);

    // 기본 category 생성
    await db.insert('category',
        {'id': 0, 'name': '할 일0', 'color': 'BD00FF', 'emoji': '🤔', 'pos': 0});

    /*
      test category 생성
     */
    await db.insert('category',
        {'id': 1, 'name': '할 일1', 'color': '00DB58', 'emoji': '🤔', 'pos': 1});
    await db.insert('category',
        {'id': 2, 'name': '할 일2', 'color': 'FF5151', 'emoji': '🤔', 'pos': 2});
  }
}
