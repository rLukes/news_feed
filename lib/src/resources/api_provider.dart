import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:news_feed/src/models/news_item_model.dart';
final _rootUrl = "https://hacker-news.firebaseio.com/v0";

class ApiProvider {
  Client client = Client();

  getTopIds() async{
    final response = await client.get(
        "$_rootUrl/topstories.json");
    final ids = json.decode(response.body);
    return ids;
  }

  getItem(int id)async {
    final response = await client.get("$_rootUrl/item/$id.json");
    final parsedJson = json.decode(response.body);
    return NewsItemModel.fromJson(parsedJson);
  }
}