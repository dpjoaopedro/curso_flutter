import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseService<T> {
  Future<Database> database;
  int version = 1;

  BaseService() {
    onInit();
  }

  onInit() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'expense_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE transactions(id TEXT PRIMARY KEY, title TEXT, value DECIMAL, date DATETIME)",
        );
      },
      version: version,
    );
  }
}
