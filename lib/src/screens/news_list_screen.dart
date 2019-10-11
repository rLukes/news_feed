import 'package:flutter/material.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Latest News"),
      ),
      body: buildNewsList(),
    );
  }

  Widget buildNewsList(){
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext ctx, int index){
        return FutureBuilder(
          future: Future.delayed(Duration(seconds: 299)),
          builder: (context, snapshot){
            return snapshot.hasData ?
                Text("news...")
                : Text("ss");
          }
        );
      },
    );
  }
}
