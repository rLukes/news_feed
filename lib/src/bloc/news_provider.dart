import 'package:flutter/material.dart';
import 'news_bloc.dart';

class NewsProvider extends InheritedWidget {
  final NewsBloc newsBloc;

  NewsProvider({Key key, Widget child})
      : newsBloc = NewsBloc(),
        super(key: key, child: child);

  static NewsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(NewsProvider) as NewsProvider)
        .newsBloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
