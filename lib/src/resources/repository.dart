import 'package:news_feed/src/models/news_item_model.dart';
import 'package:news_feed/src/resources/api_provider.dart';
import 'package:news_feed/src/resources/db_provider.dart';

class Repository {
  DbProvider dbProvider = DbProvider();
  ApiProvider apiProvider = ApiProvider();

  Future<List<int>> getTopIds() {
    return apiProvider.getTopIds();
  }

  Future<NewsItemModel> getItem(int id) async {
    var newsItem = await dbProvider.getNewsItem(id);
    if (newsItem != null) {
      return newsItem;
    } else {
      newsItem = await apiProvider.getItem(id);
      await dbProvider.addNewsItem(newsItem);
      return newsItem;
    }
  }
}
