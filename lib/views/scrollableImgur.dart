import 'package:epicture/views/imageScrollable.dart';
import 'package:flutter/material.dart';

class ScrollableImgur extends StatefulWidget {
  ScrollableImgur({Key key, this.toSearch = '', this.category = 'hot'}) : super(key: key);

  final String category;
  final String toSearch;

  _ScrollableImgurState createState() => _ScrollableImgurState();
}

class _ScrollableImgurState extends State<ScrollableImgur> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                    icon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
                Tab(
                    icon: Icon(
                  Icons.star,
                  color: Colors.white,
                )),
                Tab(
                    icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ))
              ],
            ),
            title: Center(
              child: Text(
                'Epicture',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ImageScrollable(
                toSearch: this.widget.toSearch,
                category: this.widget.category,
              ),
              ImageScrollable(
                toSearch: this.widget.toSearch,
                category: this.widget.category,
              ),
              ImageScrollable(
                toSearch: this.widget.toSearch,
                category: this.widget.category,
              ),
            ],
          )),
    );
  }
}
