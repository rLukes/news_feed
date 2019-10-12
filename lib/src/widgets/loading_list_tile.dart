import 'package:flutter/material.dart';

class LoadingListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: buildBox(),
          subtitle: buildBox(),
        ),
        Divider(
          height: 8.1,
        )
      ],
    );
  }

  Widget buildBox() {
    return Container(
      color: Colors.grey[200],
      width: 150,
      height: 24,
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
    );
  }
}
