import 'bloc.dart';
import 'dart:async';

class SearchBloc implements BlocBase {
  String toSearch;

  StreamController<String> searchController = StreamController<String>.broadcast();
  StreamSink<String> get search => searchController.sink;
  Stream<String> get outSearch => searchController.stream;

  StreamController actionController = StreamController.broadcast();
  StreamSink get searchTag => actionController.sink;

  SearchBloc() {
    toSearch = '';
    actionController.stream.listen(handleSearch);
  }

  void handleSearch(data) {
    toSearch = data;
    search.add(toSearch);
  }

  @override
  void dispose() {
    actionController.close();
    searchController.close();
  }
}