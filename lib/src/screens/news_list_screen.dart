import 'package:flutter/material.dart';
import 'package:news_feed/src/bloc/news_bloc.dart';
import 'package:news_feed/src/bloc/news_provider.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsBloc = NewsProvider.of(context);
    newsBloc.getTopIds();
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
      ),
      body: buildNewsList(newsBloc),
    );
  }

  Widget buildNewsList(NewsBloc newsBloc){
    return StreamBuilder(
      stream: newsBloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index){
            return Text(snapshot.data[index].toString());
          },
        );
      },
    );
  }
}
