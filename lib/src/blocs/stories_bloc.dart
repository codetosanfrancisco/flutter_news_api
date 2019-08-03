import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/ItemModel.dart';

class StoriesBloc {
  //Initial setup
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  //Getter to the Blocs
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //Setter to the Blocs
  fetchTopIds() async {
    final List ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }

  get fetchItem => _itemsFetcher.sink.add;

  Future<void> clearCache() {
    return _repository.clearCache();
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
        //ScanStreamTransformer is actually an accumulator function
        (Map<int, Future<ItemModel>> cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      return cache; //return means putting the returned things back to the stream
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _topIds.close();
    _itemsFetcher.close();
    _itemsOutput.close();
  }
}
