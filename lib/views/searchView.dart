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
  int listIndex = 0;
  List<ImgurTag> tagList = [];

  @override
  void dispose() {
    super.dispose();

    scrollController.dispose();
  }

  Future<void> loadMore() async {
    int tmp = this.listIndex;
    while (tmp < this.listIndex + 10) {
      setState(() {
        this.listData..add(TagCard(tag: this.tagList[tmp]));
      });
      tmp += 1;
    }
    setState(() {
      this.listIndex += 10;
    });
  }

  @override
  void initState() {
    super.initState();

    this.scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        this.loadMore();
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
      while (this.listIndex < 10) {
        setState(() {
          this.listData.add(TagCard(tag: this.tagList[this.listIndex]));
          this.listIndex++;
        });
      }
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