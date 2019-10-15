import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/bloc/searchBloc.dart';
import 'package:epicture/objects/test.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/ImgurImageCard.dart';

class ScrollableImgur extends StatefulWidget {
  ScrollableImgur({Key key, this.toSearch = '', this.category = 'hot'}) : super(key: key);

  final String category;
  final String toSearch;
  _ScrollableImgurState createState() => _ScrollableImgurState();
}

class _ScrollableImgurState extends State<ScrollableImgur> {
  final ScrollController scrollController = ScrollController();
  List<GalleryAlbum> albums = List<GalleryAlbum>();
  int page = 1;
  final List<String> categories = ['top', 'time', 'viral'];
  String currentCategory = 'viral';

  void loadMoreImages() {
    final ImgurAPI api = ImgurAPI();

    api.getImagesFromTag(this.widget.toSearch, page: this.page, category: this.widget.category).then((data) {
      this.albums.addAll(data);
    });
    page += 1;
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
    if (this.albums.length != 0) {
      return Column(
        children: [
        Container(
          height: 50,
          color: Theme.of(context).primaryColor,
          child: Align(
            alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              value: this.currentCategory,
              onChanged: changeDropDownValue,
              items: this.categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height - 150,
          child: ListView.builder(
            itemCount: this.albums.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              return ImageCard(
                album: albums[index],
              );
            },
          ),
        ),
        ],
      );
    } else {
      return Text('Load');
    }
  }
}