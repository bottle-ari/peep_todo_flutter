import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

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
      onOpen: _onOpen,
    );
  }

  static Future _onOpen(Database db) async {
    // 외래키 제약조건 설정
    await db.execute('PRAGMA foreign_keys = ON');
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
          type INTEGER,
          is_activate INTEGER,
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
          date INTEGER,
          priority INTEGER,
          memo TEXT,
          is_checked INTEGER,
          check_time INTEGER,
          pos INTEGER,
          FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE)
      """,
    );

    // 기본 category 생성
    var uuid = const Uuid();
    String newUuid = uuid.v4();

    await db.insert('category',
        {'id': newUuid, 'name': '할 일', 'color': 'FF968A', 'emoji': '🤔', 'pos': 0});
  }
}
