import 'package:flutter/material.dart';
import 'package:epicture/views/scrollableImgur.dart';
import 'package:flutter/foundation.dart';
import 'package:epicture/views/uploadView.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> widgetOptions = <Widget>[
    ScrollableImgur(),
    Text('toto'),
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
  Widget build(BuildContext context) {
    debugPrint('Rebuild');
    debugPrint(this.currentIndex.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epicture'),
      ),
      body: this.widgetOptions.elementAt(this.currentIndex),
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
}