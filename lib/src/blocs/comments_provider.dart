import 'package:flutter/material.dart';
import './comments_bloc.dart';
export './comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc = CommentsBloc();

  CommentsProvider({Widget child, Key key}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static CommentsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(CommentsProvider)
            as CommentsProvider)
        .bloc;
  }
}
