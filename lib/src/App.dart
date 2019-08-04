import 'package:flutter/material.dart';
import 'screens/NewsList.dart';
import 'blocs/stories_provider.dart';
import 'screens/NewsDetails.dart';
import 'blocs/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CommentsProvider(
      child: StoriesProvider(
          child: MaterialApp(
        title: "News!",
        onGenerateRoute: route,
      )),
    );
  }

  MaterialPageRoute route(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context) {
        final CommentsBloc commentsBloc = CommentsProvider.of(context);
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        commentsBloc.fetchItemWithComments(itemId);

        final storiesBloc = StoriesProvider.of(context);

        storiesBloc.fetchTopIds();

        return NewsDetails(itemId: itemId);
      });
    }
  }
}
