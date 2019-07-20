import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/ItemModel.dart';

class StoriesBloc {
  //Initial setup
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Observable<Map<int, Future<ItemModel>>> items;

  //Getter to the Blocs
  Observable<List<int>> get topIds => _topIds.stream;

  //Setter to the Blocs
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  StoriesBloc() {
    items = _items.stream.transform(_itemsTransformer());
  }

  get fetchItem => _items.sink.add;

  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}
