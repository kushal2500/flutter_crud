import 'package:equations/equations.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDb {
  late Database db;

  Future open() async {
    // solution(0, 10, 30);

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo1.db');
    //join is from path package
    print(
        path); //output /data/user/0/com.testapp.flutter.testapp/databases/demo.db

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''

                    CREATE TABLE IF NOT EXISTS products( 
                          id primary key,
                          pro_no int not null,
                          name varchar(255) not null,
                          description varchar(255) not null
                      );

                      //create more table here
                  
                  ''');
      //table products will be created if there is no table 'products'
      print("Table Created");
    });
  }

  Future<Map<dynamic, dynamic>?> getProduct(int id) async {
    List<Map> maps =
        await db.query('products', where: 'pro_no = ?', whereArgs: [id]);
    //getting product data with roll no.
    if (maps.length > 0) {
      return maps.first;
    }
    return null;
  }
}
