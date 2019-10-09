import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/ImgurImageCard.dart';

class ScrollableImgur extends StatefulWidget {
  ScrollableImgur({Key key}) : super(key: key);

  _ScrollableImgurState createState() => _ScrollableImgurState();
}

class _ScrollableImgurState extends State<ScrollableImgur> {
  final ScrollController scrollController = ScrollController();

  final List<ImageCard> listData = [
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
    ImageCard(image: Image.network('https://blog.devidia.net/wp-content/uploads/2017/11/safe_image.gif', fit: BoxFit.fill,)),
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