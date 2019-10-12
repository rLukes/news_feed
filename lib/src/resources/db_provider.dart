import 'package:news_feed/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/news_item_model.dart';

class DbProvider implements Source, Cache {
  Database db;

  DbProvider() {
    init();
  }

  void init() async {
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

  Future<NewsItemModel> getItem(int id) async {
    final valueMaps = await db
        .query("NewsItem", columns: null, where: "id=?", whereArgs: [id]);
    if (valueMaps.length > 0) {
      return NewsItemModel.fromDb(valueMaps.first);
    }
    return null;
  }

  Future<int> addNewsItem(NewsItemModel item) {
    return db.insert(
      "NewsItem",
      item.toMapForDb(),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  @override
  Future<List<int>> getTopIds() {
    return null;
  }
}

final dbProvider = DbProvider();
