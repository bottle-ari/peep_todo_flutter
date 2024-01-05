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
    // palette table 생성
    await db.execute(
        """
      CREATE TABLE palette(
          id TEXT PRIMARY KEY,
          primary_color INTEGER)
      """
    );

    // color table 생성
    await db.execute(
        """
      CREATE TABLE color(
          id TEXT PRIMARY KEY,
          palette_id TEXT,
          color TEXT,
          FOREIGN KEY (palette_id) REFERENCES palette(id) ON DELETE CASCADE)
      """
    );

    // category table 생성
    await db.execute(
      """
      CREATE TABLE category(
          id TEXT PRIMARY KEY,
          name TEXT,
          color INTEGER,
          emoji TEXT,
          type INTEGER,
          is_active INTEGER,
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
          name TEXT,
          is_active INTEGER,
          priority INTEGER,
          repeat_condition TEXT,
          pos INTEGER,
          FOREIGN KEY (category_id) REFERENCES category(id) ON DELETE CASCADE)
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

    // diary table 생성
    await db.execute(
      """
      CREATE TABLE diary(
          id TEXT PRIMARY KEY,
          date INTEGER,
          image TEXT,
          memo TEXT
      )
      """
    );

    // 기본 category 생성
    var uuid = const Uuid();
    String newUuid = uuid.v4();

    await db.insert('category', {
      'id': newUuid,
      'name': '할 일',
      'color': 0,
      'emoji': '🤔',
      'type': 0,
      'is_active': true,
      'pos': 0
    });

    // 기본 palette 생성
    String newPaletteUuid = uuid.v4();

    await db.insert('palette', {
      'id': newPaletteUuid,
      'primary_color': 0,
    });

    String newColorId0 = uuid.v4();
    String newColorId1 = uuid.v4();
    String newColorId2 = uuid.v4();
    String newColorId3 = uuid.v4();
    String newColorId4 = uuid.v4();
    String newColorId5 = uuid.v4();
    String newColorId6 = uuid.v4();
    String newColorId7 = uuid.v4();
    String newColorId8 = uuid.v4();
    String newColorId9 = uuid.v4();

    await db.insert('color', {
      'id': newColorId0,
      'palette_id': newPaletteUuid,
      'color': 'FF6D79',
    });

    await db.insert('color', {
      'id': newColorId1,
      'palette_id': newPaletteUuid,
      'color': 'FF9089',
    });

    await db.insert('color', {
      'id': newColorId2,
      'palette_id': newPaletteUuid,
      'color': 'FFBE94',
    });

    await db.insert('color', {
      'id': newColorId3,
      'palette_id': newPaletteUuid,
      'color': 'FCD268',
    });

    await db.insert('color', {
      'id': newColorId4,
      'palette_id': newPaletteUuid,
      'color': 'C3EA86',
    });

    await db.insert('color', {
      'id': newColorId5,
      'palette_id': newPaletteUuid,
      'color': '87E3C1',
    });

    await db.insert('color', {
      'id': newColorId6,
      'palette_id': newPaletteUuid,
      'color': '88BB8D',
    });

    await db.insert('color', {
      'id': newColorId7,
      'palette_id': newPaletteUuid,
      'color': 'D98FDF',
    });

    await db.insert('color', {
      'id': newColorId8,
      'palette_id': newPaletteUuid,
      'color': 'E38E79',
    });

    await db.insert('color', {
      'id': newColorId9,
      'palette_id': newPaletteUuid,
      'color': 'BF9663',
    });
  }
}
