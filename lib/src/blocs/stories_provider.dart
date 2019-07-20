//Provider is like the Connect function of React Redux which helps to link Redux Store to Every Component in React
//Because in React, if a component wants to talk to the store, it needs to use connect function.
//The store is at one place, and the component is at another place, hence connect function is important.

import 'package:flutter/material.dart';
import 'stories_bloc.dart';
export 'stories_bloc.dart';

//We create Provider in Flutter so that every children widgets below the widget where the Bloc is created can acess the Bloc
class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc = StoriesBloc();

  StoriesProvider({Key key, Widget child}) : super(child: child);

  bool updateShouldNotify(_) => true;

  static StoriesBloc of(context) {
    return (context.inheritFromWidgetOfExactType(StoriesProvider)
            as StoriesProvider)
        .bloc;
  }
}
