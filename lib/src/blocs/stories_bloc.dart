import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/ItemModel.dart';

class StoriesBloc {
  //Initial setup
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();

  //Getter to the Blocs
  Observable<List<int>> get topIds => _topIds.stream;

  //Setter to the Blocs
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  dispose() {
    _topIds.close();
  }
}
