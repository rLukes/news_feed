import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/news_item_model.dart';

class DbProvider {
  Database db;

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, "news_ items.db");
    db = await openDatabase(dbPath, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE NewsItem(
        id INTEGER PRIMARY KEY,
        type TEXT,
        by TEX  T,
        time INTEGER,
        text TEXT,
        parent INTEGER,
        kids BLOB,
        dead INTEGER, 
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER       
        )
        """);
    });
  }

  getNewsItem(int id)async{
    final valueMaps = await db.query(
      "NewsItem",
      columns: null,
      where: "id=?",
      whereArgs: [id]
    );
    if(valueMaps.length > 0){
      return NewsItemModel.fromDb(valueMaps.first);
    }
    return null;
  }

  addNewsItem(NewsItemModel item){
    return db.insert("NewsItem", item.toMapForDb());
  }

}
