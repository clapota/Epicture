import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/objects/test.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/ImgurImageCard.dart';

class ScrollableImgur extends StatefulWidget {
  ScrollableImgur({Key key, this.toSearch = ''}) : super(key: key);

  final String toSearch;
  _ScrollableImgurState createState() => _ScrollableImgurState();
}

class _ScrollableImgurState extends State<ScrollableImgur> {
  final ScrollController scrollController = ScrollController();
  List<GalleryAlbum> albums = List<GalleryAlbum>();
  int page = 1;

  void loadMoreImages() {
    final ImgurAPI api = ImgurAPI();

    api.getImagesFromTag(this.widget.toSearch, page: this.page).then((data) {
      this.albums.addAll(data);
    });
    page += 1;
  }

  @override
  void initState() {
    super.initState();
    debugPrint('jai me le cu');

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
          this.loadMoreImages();
        }
    });
    final ImgurAPI api = ImgurAPI();

    debugPrint('zizi dans le zozo');
    api.getImagesFromTag(this.widget.toSearch).then((data) {
      if (data == null)
        debugPrint('null data ');
      else {
        debugPrint(data.length.toString());
        setState(() {
          this.albums = data;
          this.page += 1;
        });
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
    debugPrint('ALED');
    if (this.albums.length != 0) {
      return 
        ListView.builder(
          itemCount: this.albums.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return ImageCard(
              album: albums[index],
            );
          },
        );
    } else {
      return Text('Load');
    }
  }
}