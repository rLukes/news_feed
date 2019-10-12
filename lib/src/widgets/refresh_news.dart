import 'package:flutter/material.dart';
import 'package:news_feed/src/bloc/news_provider.dart';

class RefreshNews extends StatelessWidget {
  final Widget child;

  RefreshNews({this.child});

  @override
  Widget build(BuildContext context) {
    final newsBloc = NewsProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await newsBloc.clearCache();
        await newsBloc.getTopIds();
      },
    );
  }
}
