import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Save_sql.dart';

final String columnId = 'id';
final String columnTitle = 'title';
final String columnImage = 'image';
final String columnRate = 'rating';
final String columnYear = 'year';
final String columnTrailer = 'trailer';
final String columnGenre = 'Genre';


class SaveDB {
  late Database db;
  static final SaveDB instance = SaveDB._internal();

  factory SaveDB() {
    return instance;
  }
  SaveDB._internal();
  Future open() async {
    db = await openDatabase(join(await getDatabasesPath(), 'save_table.db'),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute('''
          create table save_table (
          $columnId text not null,
          $columnTitle text not null,
          $columnImage text not null,
          $columnRate text not null,
          $columnYear integer not null,
          $columnTrailer text not null,
          $columnGenre text not null
          )
          ''');
        });
  }

  Future<String> insertSave(Save save) async {
    save.id = await db.insert('save_table', save.toMap()).toString();
    return save.id ;
  }

  Future<String> delete(String id) async {
    return await db
        .delete('save_table', where: '$columnId = ?', whereArgs: [id]).toString();
  }

  Future<List<Save>> getAllSaved() async {
    List<Map<String, dynamic>> SaveMaps = await db.query('save_table');
    if (SaveMaps.isEmpty) {
      return [];
    } else {
      List<Save> saves = [];
      for (var element in SaveMaps) {
        saves.add(Save.fromMap(element));
      }
      return saves;
    }
  }

  Future close() async => db.close();
}
