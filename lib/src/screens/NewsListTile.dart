import 'package:flutter/material.dart';
import '../blocs/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    // TODO: implement build
    bloc.fetchItem(itemId);
    return StreamBuilder(
      stream: bloc.items,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Stream still loading");
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text("Still loading the item $itemId");
            }

            return Text(itemSnapshot.data.title);
          },
        );
      },
    );
  }
}
