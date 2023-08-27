import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class OpenDatabase{
  static const String _sqlFunctionsTable = "CREATE TABLE functions("
      "id INTEGER PRIMARY KEY,"
      "description TEXT"
      ");";
  static const String _sqlUsersTable = "CREATE TABLE users("
      "id INTEGER PRIMARY KEY,"
      "id_function INTEGER,"
      "name TEXT,"
      "email TEXT,"
      "user TEXT,"
      "password TEXT,"
      "FOREIGN KEY(id_function) REFERENCES functions(id)"
      ");";
  static const String _sqlTaskTable = "CREATE TABLE tasks("
      "id INTEGER PRIMARY KEY,"
      "id_user INTEGER,"
      "title TEXT,"
      "description TEXT,"
      "priority INTEGER,"
      "FOREIGN KEY(id_user) REFERENCES users(id)"
      ");";
  static  const String _sqlSubTaskTable = "CREATE TABLE subtasks("
      "id INTEGER PRIMARY KEY,"
      "id_task INTEGER,"
      "description TEXT,"
      "completed INTEGER,"
      "FOREIGN KEY(id_task) REFERENCES tasks(id)"
      ");";

    static Future<Database> getDatabase() async{
      String path = join(await getDatabasesPath(), 'database.db');
      return openDatabase(path,version: 1,onCreate: (db, version){
        db.execute(_sqlFunctionsTable);
        db.execute(_sqlUsersTable);
        db.insert("functions", {
          "description" : "Administrador"
        });
        db.insert("users", {
          "id_function" : 1,
          "name" : "Administrador",
          "email" : "adm@adm.com",
          "user" : "admin",
          "password" : "myTask123"
        });

        db.execute(_sqlTaskTable);
        return db.execute(_sqlSubTaskTable);
      });
    }
}