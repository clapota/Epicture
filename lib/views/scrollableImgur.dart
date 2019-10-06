import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/ImgurImageCard.dart';

class ScrollableImgur extends StatefulWidget {
  ScrollableImgur({Key key}) : super(key: key);

  _ScrollableImgurState createState() => _ScrollableImgurState();
}

class _ScrollableImgurState extends State<ScrollableImgur> {
  final ScrollController scrollController = ScrollController();

  final List<ImageCard> listData = [
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
    ImageCard(),
  ];

  void loadMoreImages() {
    setState(() {
      listData..addAll(List<ImageCard>.from(listData));
    });
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        this.loadMoreImages();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('test infinite scroll')),
      body: ListView.builder(
        itemCount: listData.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return listData[index];
        },
      )
    );
  }
}