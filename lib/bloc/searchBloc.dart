import 'package:epicture/objects/SearchData.dart';

import 'bloc.dart';
import 'dart:async';

class SearchBloc implements BlocBase {
  SearchData toSearch;

  StreamController<SearchData> searchController = StreamController<SearchData>.broadcast();
  StreamSink<SearchData> get search => searchController.sink;
  Stream<SearchData> get outSearch => searchController.stream;

  StreamController actionController = StreamController.broadcast();
  StreamSink get searchTag => actionController.sink;

  SearchBloc() {
    toSearch = SearchData(toSearch: '', category: 'hot');
    actionController.stream.listen(handleSearch);
  }

  void handleSearch(data) {
    String dataString = data.toString();
    if (dataString.contains('category')) {
      toSearch.category = dataString.split(' ')[1];
    } else if (dataString.contains('toSearch')) {
      toSearch.toSearch = dataString.split(' ')[1];
    }
    search.add(toSearch);
  }

  @override
  void dispose() {
    actionController.close();
    searchController.close();
  }
}