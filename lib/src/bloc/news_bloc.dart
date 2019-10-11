import 'package:news_feed/src/models/news_item_model.dart';
import 'package:news_feed/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class NewsBloc {
  final _repository = new Repository();
  final _topIds = new PublishSubject<List<int>>();

  final _items = BehaviorSubject<int>();

  Observable<List<int>> get topIds => _topIds.stream;

  Function(int) get getItem => _items.sink.add;


  void getTopIds() async {
    var ids = await _repository.getTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<NewsItemModel>> cache, int id, _) {
        cache[id] = _repository.getItem(id);
        return cache;
      },
      <int, Future<NewsItemModel>>{},
    );
  }

  void dispose() {
    _topIds.close();
    _items.close();
  }
}
