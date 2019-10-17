import 'package:epicture/ImgurAPI.dart';
import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/views/widgets/NetworkImageLoader.dart';
import 'package:flutter/material.dart';
import 'package:epicture/objects/ImgurTag.dart';
import 'package:epicture/bloc/searchBloc.dart';

class TagCard extends StatelessWidget {
  TagCard({Key key, this.tag}) : super(key: key);

  final ImgurTag tag;

  void notifySearchStream(BuildContext context) {
    final SearchBloc bloc = BlocProvider.of<SearchBloc>(context);

    bloc.searchTag.add('toSearch ' + this.tag.name);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 300,
        width: 150,
        child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                NetworkImageLoader(ImgurAPI().getImageFromHash(this.tag.thumbnailHash ?? this.tag.backgroundHash)),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Center(
                    child: Text(
                      this.tag.displayName,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                  ),
                  height: 30.0,
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                    color: this.tag.accent != null
                        ? Color(int.parse("FF" + this.tag.accent, radix: 16))
                        : Colors.grey[600],
                  ),
                )
              ],
            )),
      ),
      onTap: () => notifySearchStream(context),
    );
  }
}
