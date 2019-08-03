import 'package:flutter/material.dart';
import 'dart:async';
import '../models/ItemModel.dart';
import 'LoadingContainer.dart';

class Comment extends StatelessWidget {
  final int itemId;

  final Map<int, Future<ItemModel>> itemMap;

  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final children = <Widget>[
          ListTile(
            contentPadding: EdgeInsets.only(right: 16.0, left: depth * 16.0),
            title: buildText(snapshot.data),
            subtitle: snapshot.data.by == ""
                ? Text("Deleted")
                : Text(snapshot.data.by),
          ),
          Divider()
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(children: children);
      },
    );
  }

  Text buildText(ItemModel item) {
    final text = item.text
        .replaceAll('&#x27;', " ' ")
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
  }
}
