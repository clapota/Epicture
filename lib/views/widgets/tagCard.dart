import 'package:epicture/ImgurAPI.dart';
import 'package:flutter/material.dart';
import 'package:epicture/objects/ImgurTag.dart';

class TagCard extends StatefulWidget {
  TagCard({Key key, this.tag}) : super(key: key);

  ImgurTag tag;
  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  Image _image = Image.asset("assets/imgur.png");

  void doSomething() {}

  @override
  void initState() { 
    super.initState();
    var api = ImgurAPI();

    Image image = api.getImageFromHash(this.widget.tag.backgroundHash);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.white,
        child: this._image,
      ),
      onTap: doSomething,
    );
  }
}