import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class RawQueryDatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        category_id INTEGER,
        category_name TEXT,
        category_img_url TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    await database.execute("""CREATE TABLE recipes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        recipes_id INTEGER,
        recipe_title TEXT,
        recipe_description TEXT,
        recipe_img_url TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite



}