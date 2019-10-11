import 'package:flutter/material.dart';
import 'package:news_feed/src/bloc/news_provider.dart';
import 'package:news_feed/src/screens/news_list_screen.dart';

class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsProvider(
      child: MaterialApp(
        title: "News Feed",
        home: NewsListScreen(),
      ),
    );
  }
}
