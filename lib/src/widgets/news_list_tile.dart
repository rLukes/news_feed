import 'package:flutter/material.dart';
import 'package:news_feed/src/bloc/news_provider.dart';
import 'package:news_feed/src/models/news_item_model.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final newsBloc = NewsProvider.of(context);

    return StreamBuilder(
      stream: newsBloc.items,
      builder:
          (context, AsyncSnapshot<Map<int, Future<NewsItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return Text("loading");
        }
        return FutureBuilder(
            future: snapshot.data[itemId],
            builder: (context, AsyncSnapshot<NewsItemModel> itemSnapshot) {
              if (!itemSnapshot.hasData) {
                return Text("LOADING ....$itemId");
              }
              return buildNewTile(itemSnapshot.data);
            });
      },
    );
  }

  Widget buildNewTile(NewsItemModel item) {
    return ListTile(
      title: Text(item.title),
      subtitle: Text('${item.score} votes'),
      trailing: Column(
        children: <Widget>[
          Icon(Icons.comment),
          Text('${item.descendants}')
        ],
      ),
    );
  }
}
