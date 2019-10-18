import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/bloc/searchBloc.dart';
import 'package:epicture/objects/GalleryAlbum.dart';
import 'package:epicture/views/widgets/ImgurImageCard.dart';
import 'package:flutter/material.dart';

import '../ImgurAPI.dart';

class ImageScrollable extends StatefulWidget {
  ImageScrollable({Key key, this.toSearch = '', this.category = 'hot'}) : super(key: key);

  final String category;
  final String toSearch;

  _ImageScrollable createState() => _ImageScrollable();
}

class _ImageScrollable extends State<ImageScrollable> {
  final ScrollController scrollController = ScrollController();
  List<GalleryAlbum> albums = List<GalleryAlbum>();
  int page = 1;
  final List<String> categories = ['top', 'time', 'viral'];
  String currentCategory = 'viral';

  void loadMoreImages() {
    final ImgurAPI api = ImgurAPI();

    page += 1;
    print("loading page $page");
    api.getImagesFromTag(this.widget.toSearch, page: this.page, category: this.widget.category).then((data) {
      setState(() {
        this.albums.addAll(data);
      });
    });
  }

  void changeDropDownValue(String value) {
    final searchBloc = BlocProvider.of<SearchBloc>(this.context);
    setState(() {
      this.currentCategory = value;
    });
    searchBloc.searchTag.add('category ' + value);
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        this.loadMoreImages();
      }
    });
    final ImgurAPI api = ImgurAPI();

    api.getImagesFromTag(this.widget.toSearch, page: this.page, category: this.widget.category).then((data) {
      if (data != null) {
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
    return ListView(
      children: [
        ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: this.albums.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return ImageCard(
              album: albums[index],
            );
          },
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
