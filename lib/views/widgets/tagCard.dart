import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:epicture/bloc/searchBloc.dart';

class TagCard extends StatefulWidget {
  TagCard({Key key, this.tag}) : super(key: key);

  final ImgurTag tag;

  _TagCardState createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  PaletteGenerator paletteGenerator;

  void notifySearchStream() {
    final SearchBloc bloc = BlocProvider.of<SearchBloc>(this.context);

    bloc.searchTag.add(this.widget.tag.name);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ImgurAPI().getImageFromHash(this.widget.tag.backgroundHash),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text(
                    this.widget.tag.displayName,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
                height: 30.0,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                  color: this.widget.tag.accent != null ? Color(int.parse("FF" + this.widget.tag.accent, radix: 16)) : Colors.grey[600],
                ),
              )
            ],
          )),
      onTap: notifySearchStream,
    );
  }
}
