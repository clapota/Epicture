import 'package:epicture/bloc/bloc.dart';
import 'package:epicture/bloc/searchBloc.dart';
import 'package:epicture/objects/SearchData.dart';
import 'package:flutter/material.dart';
import 'package:epicture/views/scrollableImgur.dart';
import 'package:flutter/foundation.dart';
import 'package:epicture/views/uploadView.dart';
import 'package:epicture/views/searchView.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  String oldValue = '';
  String category = 'hot';
  List<Widget> widgetOptions = <Widget>[
    ScrollableImgur(),
    SearchView(),
    UploadPhotoView()
  ];

  void onItemTapped(int index)
  {
    debugPrint(index.toString());
    setState(() {
      this.currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    debugPrint('TEST BITE ' + this.oldValue);
    this.widgetOptions[0] = ScrollableImgur(toSearch: this.oldValue);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      bloc: SearchBloc(),
      child: Builder(builder: (context) {return StreamBuilder<SearchData>(
        initialData: SearchData(toSearch: ''),
        stream: BlocProvider.of<SearchBloc>(context).outSearch,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.toSearch != this.oldValue) {
            this.currentIndex = 0;
            this.oldValue = snapshot.data.toSearch;
            this.category = snapshot.data.category;
            this.widgetOptions[0] = ScrollableImgur(toSearch: this.oldValue, category: this.category);
          } else if (snapshot.hasData && snapshot.data.category != this.category) {
            debugPrint('zz\'rot');
            this.category = snapshot.data.category;
            this.widgetOptions[0] = ScrollableImgur(toSearch: this.oldValue, category: this.category);
          }

          return Scaffold(
            body: Container(
              color: Colors.white70,
              child: widgetOptions.elementAt(this.currentIndex)
              ),
            bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Search'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.photo),
                  title: Text('Upload picture')
                ),
              ],
              currentIndex: this.currentIndex,
              selectedItemColor: Theme.of(context).primaryColor,
              onTap: onItemTapped,
            ),
          );
        }
      );
    })
    );
  }
}