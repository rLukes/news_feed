import 'package:news_feed/src/models/news_item_model.dart';
import 'package:news_feed/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class NewsBloc {
  final _repository = new Repository();
  final _topIds = new PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<NewsItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();


  
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<NewsItemModel>>> get items => _itemsOutput.stream;

  Function(int) get getItem => _itemsFetcher.sink.add;

  NewsBloc(){
   _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutput);
  }


  void getTopIds() async {
    var ids = await _repository.getTopIds();
    _topIds.sink.add(ids);
  }

  _itemsTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<NewsItemModel>> cache, int id, index) {
        cache[id] = _repository.getItem(id);
        return cache;
      },
      <int, Future<NewsItemModel>>{},
    );
  }

  clearCache(){
    return _repository.clearCache();
  }

  void dispose() {
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
