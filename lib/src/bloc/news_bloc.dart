import 'package:news_feed/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc{
  final _repository = new Repository();
  final _topIds = new PublishSubject<List<int>>();

  Observable<List<int>> get topIds => _topIds.stream;

  getTopIds()async{
    var ids = await _repository.getTopIds();
    _topIds.sink.add(ids);
  }

  void dispose(){
    _topIds.close();
  }
}