import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/objects/test.dart';
import 'package:epicture/views/CommentView.dart';
import 'package:epicture/views/widgets/FadeRoute.dart';
import 'package:epicture/views/widgets/NetworkImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/widgets/PressableIconWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:core';

class ImageCard extends StatefulWidget {
  ImageCard({Key key, this.album}) : super(key: key);

  final GalleryAlbum album;

  _ImageCardState createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  List<GalleryImages> images = List<GalleryImages>();
  int _current = 0;

  void showImage() {}

  void onClick() {}

  List<Container> makeContainers(int size) {
    List<Container> containers = List<Container>();
    for (var i = 0; i < size; i++) {
      containers.add(Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: _current == i ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4)),
      ));
    }
    return containers;
  }

  void addFavorite() {
    if (this.widget.album.favorite != true) {
      final ImgurAPI api = ImgurAPI();

      api.addFavorite(this.widget.album.id).then((statusCode) {
        debugPrint(statusCode.toString());
        if (statusCode == 200) {
          debugPrint('Added with success album of id ' + this.widget.album.id + ' as favorite');
          this.widget.album.favorite = true;
        }
      });
    }
  }

  void showComments() {
    Navigator.push(context, FadeRoute(page: CommentView(album: this.widget.album)));
  }

  List<Widget> getOnlyImages(List<GalleryImages> images, {bool thumbnail = false}) {
    return images
        .where((img) => img.type.contains('image'))
        .map((img) => NetworkImageLoader(thumbnail ? ImgurAPI().getImageThumbnail(img.link) : (img.link))).toList();
  }

  @override
  void initState() {
    super.initState();

    if (this.widget.album.images != null) {
      setState(() {
        this.images = this.widget.album.images.where((img) => img.type.contains('image')).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.images.length == 0) {
      return Text('No image');
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 10,
        color: Colors.white,
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    FadeRoute(
                      page: DetailScreen(
                        image: NetworkImageLoader(this.images[this._current].link),
                      ),
                    ));
              },
              child: this.images.length > 1
                  ? Stack(children: [
                      CarouselSlider(
                        items: getOnlyImages(this.widget.album.images, thumbnail: true),
                        autoPlay: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      Positioned(
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: makeContainers(images.length),
                          ))
                    ])
                  : NetworkImageLoader(ImgurAPI().getImageThumbnail(images[0].link))),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                gradient: LinearGradient(
                    colors: const [Color(0xFFFD60A3), Color(0xFFFF8961)],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8.0, 0),
                  child: Text(
                    this.widget.album.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    PressableIconWidget(
                      iconData: Icons.thumb_up,
                      label: this.widget.album.ups.toString(),
                      onClick: this.onClick,
                      pressedColor: Colors.greenAccent,
                      iconSize: 20.0,
                    ),
                    PressableIconWidget(
                      iconData: Icons.thumb_down,
                      label: this.widget.album.downs.toString(),
                      onClick: this.onClick,
                      pressedColor: Colors.black,
                      iconSize: 20.0,
                    ),
                    PressableIconWidget(
                      iconData: Icons.comment,
                      label: this.widget.album.commentCount.toString(),
                      onClick: this.showComments,
                      pressedColor: Colors.white,
                      iconSize: 20.0,
                    ),
                    PressableIconWidget(
                      iconData: Icons.remove_red_eye,
                      label: this.widget.album.views.toString(),
                      onClick: this.onClick,
                      pressedColor: Colors.white,
                      iconSize: 20.0,
                    ),
                    PressableIconWidget(
                      iconData: Icons.star,
                      label: '',
                      onClick: this.addFavorite,
                      pressedColor: Colors.yellow,
                      iconSize: 20.0,
                    )
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  DetailScreen({this.image});

  final Widget image;

  @override
  State<StatefulWidget> createState() {
    return _DetailScreen();
  }
}

class _DetailScreen extends State<DetailScreen> {
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;
  double yTranslation = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      child: Center(
          child: Opacity(
        child: Transform.scale(
          child: Transform.translate(
            child: this.widget.image,
            offset: Offset(0.0, this.yTranslation),
          ),
          scale: 1 - (yTranslation.abs() * 0.002),
        ),
        opacity: 1 - (yTranslation.abs() * 0.002),
      )),
      onTap: () => Navigator.pop(context),
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
        double dy = updateVerticalDragDetails.globalPosition.dy - startVerticalDragDetails.globalPosition.dy;
        setState(() {
          this.yTranslation = dy;
        });
      },
      onVerticalDragEnd: (endDetails) {
        double dx = updateVerticalDragDetails.globalPosition.dx - startVerticalDragDetails.globalPosition.dx;
        double dy = updateVerticalDragDetails.globalPosition.dy - startVerticalDragDetails.globalPosition.dy;
        double velocity = endDetails.primaryVelocity;
        setState(() {
          this.yTranslation = 0.0;
        });
        dx = dx.abs();
        dy = dy.abs();

        if (dy > 50) Navigator.pop(context);
      },
    ));
  }
}
