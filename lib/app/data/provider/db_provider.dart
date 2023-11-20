import 'package:get/get.dart';
import 'package:peep_todo_flutter/app/data/database/database_init.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider extends GetxService {
  Future<Database> db = DatabaseInit().database;



  Future<List<Map<String, Object?>>> getTodoAll() async {
    Database db = await DatabaseInit().database;
    return  await db.query('todo');
  }


}
