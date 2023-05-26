import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
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
        category_id INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

    print("Table created");
  }
// id: the id of a item
// title, description: name and description of your activity
// created_at: the time that the item was created. It will be automatically handled by SQLite

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'sar_mal.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);

      },
    );
  }

  // Create new categories
  static Future<int> createCategory(int cID,String? cName, String? cImaUrl) async {
    final db = await DatabaseHelper.db();

    final data = {'category_id': cID, 'category_name': cName,'category_img_url': cImaUrl};
    final id = await db.insert('categories', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await DatabaseHelper.db();
    return db.query('categories', orderBy: "id");
  }

  // Get a single categories by id
  //We dont use this method, it is for you if you want it.
  static Future<List<Map<String, dynamic>>> getCategory(int id) async {
    final db = await DatabaseHelper.db();
    // return db.query('categories', where: "id = ?", whereArgs: [id], limit: 1);
    var resultSet = db.rawQuery("");
    return resultSet;
  }


  // Create new Recepie
  static Future<int> createRecepie(int rID,String? rTitle, String? rDescription,String? rImgUrl,int cID) async {
    final db = await DatabaseHelper.db();

    final data = {'recipes_id': rID, 'recipe_title': rTitle,'recipe_description':rDescription,'recipe_img_url': rImgUrl,'category_id':cID};
    final id = await db.insert('recipes', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  // Read all recipes
  static Future<List<Map<String, dynamic>>> getRecepies() async {
    final db = await DatabaseHelper.db();
    return db.query('recipes', orderBy: "id");
  }

  // Get a single recipes by id
  //We dont use this method, it is for you if you want it.
  static Future<List<Map<String, dynamic>>> getOneRecepie(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('recipes', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await DatabaseHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
    await db.update('items', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}