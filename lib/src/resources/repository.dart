import 'package:news_feed/src/models/news_item_model.dart';
import 'package:news_feed/src/resources/api_provider.dart';
import 'package:news_feed/src/resources/db_provider.dart';

class Repository {
  List<Source> sources = <Source>[
    dbProvider,
    ApiProvider(),
  ];

  List<Cache> caches = <Cache>[
    dbProvider,
  ];

  Future<List<int>> getTopIds() {
    return sources[1].getTopIds();
  }

  Future<NewsItemModel> getItem(int id) async {
    NewsItemModel newsItem;
    var source;
    for (source in sources) {
      newsItem = await source.getItem(id);
      if (newsItem != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addNewsItem(newsItem);
      }
    }
    return newsItem;
  }
}

abstract class Source {
  Future<List<int>> getTopIds();

  Future<NewsItemModel> getItem(int id);
}

abstract class Cache {
  Future<int> addNewsItem(NewsItemModel item);
}
