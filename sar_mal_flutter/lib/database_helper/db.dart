import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb{
   late Database db;

  Future open() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'Library.db');
    //join is from path package
    print(path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // // When creating the db, create the table
          // await db.execute('''
          //
          //         CREATE TABLE IF NOT EXISTS books(
          //               id primary key,
          //               coverPhoto varchar(255) not null,
          //               title varchar(255) not null,
          //               autherName varchar(255) not null,
          //               description varchar(255) not null,
          //               pdfName varchar(255) not null
          //           );
          //
          //       ''');
          // //table students will be created if there is no table 'students'
          // print("Table Created");

          await db.execute("""CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        category_id INTEGER,
        category_name TEXT,
        category_img_url TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);

          await db.execute("""CREATE TABLE recipes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        recipes_id INTEGER,
        recipe_title TEXT,
        recipe_description TEXT,
        recipe_img_url TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
        });
  }

  Future<Map<dynamic, dynamic>?> getCategory(int cID) async {
    List<Map> maps = await db.query('categories',
        where: 'category_id = ?',
        whereArgs: [cID]);
    //getting getBbook data with id.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}