import 'package:rxdart/rxdart.dart';
import '../models/ItemModel.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams
  Observable<Map<int, Future<ItemModel>>> get itemsWithComments =>
      _commentsOutput.stream;

  //Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  CommentsBloc() {
    _commentsFetcher.stream
        .transform(_commentsTransformer())
        .pipe(_commentsOutput);
  }

  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
        (Map cache, int id, index) {
      cache[id] = _repository.fetchItem(id);
      cache[id].then((item) {
        item.kids.forEach((id) {
          fetchItemWithComments(id);
        });
      });
      return cache;
    }, <int, Future<ItemModel>>{});
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}
