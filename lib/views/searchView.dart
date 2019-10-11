import 'package:epicture/ImgurAPI.dart';
import 'package:flutter/material.dart';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:epicture/views/widgets/tagCard.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final ScrollController scrollController = ScrollController();
  final List<Widget> listData = [];
  bool isLoading = false;
  int listIndex = 0;
  List<ImgurTag> tagList = [];

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  Future<List<Widget>> getSomeImages(int number) async {
    List<Widget> list = [];
    int tmp = this.listIndex;
    while (tmp < this.listIndex + number) {
      list.add(TagCard(tag: this.tagList[tmp],));
      tmp++;
    }
    setState(() {
      this.listIndex += 5;
    });
    return list;
  }

  Future<void> loadMore(int number) async {
    if (!this.isLoading) {
      setState(() {
        isLoading = true;
      });
      this.getSomeImages(number).then((list) {
        setState(() {
          debugPrint('old list lenght : ' + list.length.toString());
          this.listData..addAll(list);
          debugPrint('list length : ' + this.listData.length.toString());
        });
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    this.scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        this.loadMore(2);
      }
    });
    var api = ImgurAPI();
    api.getTags().then((jsonData) {
      if (!jsonData.containsKey("data")) {
        throw Exception("can't reach api");
      }
      var data = jsonData["data"];
      if (!data.containsKey("tags"))
        throw Exception("No tags in request");
      List tags = data["tags"];
      setState(() {
        this.tagList = tags.map((tagJson) => ImgurTag.fromJson(tagJson)).toList();
      });
      this.loadMore(5);
    });
  }

  @override
  Widget build(BuildContext context) {
    return 
    ListView.builder(
      itemCount: listData.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        return listData[index];
      },
    );
  }
}