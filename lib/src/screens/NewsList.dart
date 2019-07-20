import 'package:flutter/material.dart';
import 'dart:async';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    //only build enough items to fill the screen
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (BuildContext context, int index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (BuildContext context, snapshot) {
            return snapshot.hasData
                ? Text("Im visible $index")
                : Text("I haven't fetched data yet $index");
          },
        );
      },
    );
  }

  Future getFuture() {
    return Future.delayed(Duration(seconds: 2), () => "hi");
  }
}
