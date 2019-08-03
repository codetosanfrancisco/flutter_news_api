import 'package:flutter/material.dart';
import '../blocs/comments_provider.dart';
import '../models/ItemModel.dart';
import '../widgets/Comments.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  NewsDetails({this.itemId});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bloc = CommentsProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail"),
      ),
      body: buildBody(bloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
        stream: bloc.itemsWithComments,
        builder:
            (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
          if (!snapshot.hasData) {
            return Text("Data Loading!");
          }

          final itemFuture = snapshot.data[itemId];

          return FutureBuilder(
            future: itemFuture,
            builder:
                (BuildContext context, AsyncSnapshot<ItemModel> ItemSnapshot) {
              if (!ItemSnapshot.hasData) {
                return Text("Data Loading!");
              }

              return BuildList(ItemSnapshot.data, snapshot.data);
            },
          );
        });
  }

  BuildList(ItemModel data, Map<int, Future<ItemModel>> map) {
    final children = <Widget>[];
    children.add(BuildTitle(data));
    final commentsList = data.kids.map((itemId) {
      return Comment(
        itemId: itemId,
        itemMap: map,
        depth: 1,
      );
    }).toList();

    children.addAll(commentsList);

    return ListView(children: children);
  }

  Widget BuildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
