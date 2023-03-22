import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import '../../screens/Login&RegisterScreen/UserModel.dart';

class Dbhelper {

   Database? _db;

  static const String Table_User = 'user';
  static const int Version = 1;
  static const String DB_Name = 'test.db';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  initDb() async{
    io.Directory documentdiroctory = await getApplicationDocumentsDirectory();
    String path = join(documentdiroctory.path,DB_Name );
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

   _onCreate(Database db, int intVersion) async {
     await db.execute("CREATE TABLE $Table_User ("
         " $C_UserName TEXT, "
         " $C_Email TEXT,"
         " $C_Password TEXT, "
         " PRIMARY KEY ($C_UserName)"
         ")");
   }

  Future<int?> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String UserName, String password) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserName = '$UserName' AND "
        "$C_Password = '$password'");

    if (res!.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }
    return null;

  }

}