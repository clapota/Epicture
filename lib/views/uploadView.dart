import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class UploadPhotoView extends StatefulWidget {
  UploadPhotoView({Key key}) : super(key: key);

  _UploadPhotoViewState createState() => _UploadPhotoViewState();
}

class _UploadPhotoViewState extends State<UploadPhotoView> {
  File _image;

  final tween = MultiTrackTween([
    Track("color1").add(Duration(seconds: 3),
      ColorTween(begin: Color(0xffD38312), end: Colors.lightBlue.shade900)),
    Track("color2").add(Duration(seconds: 3),
      ColorTween(begin: Color(0xffA83279), end: Colors.blue.shade900)),
  ]);

  Future accessGallery() async {
    debugPrint('go in photo gallery');
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future accessCamera() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  uploadImage()
  {
    debugPrint('Upload image here');
  }

  @override
  Widget build(BuildContext context) {
/*    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 100),
       child: 
       Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
            RaisedButton.icon(icon: Icon(Icons.photo), label: Text('Take from gallery'), onPressed: this.accessGallery,),
            RaisedButton.icon(icon: Icon(Icons.photo_camera), label: Text('take photo'), onPressed: this.accessCamera,),
            this._image == null ?
            Text('no image selected') :
            RaisedButton.icon(icon: Icon(Icons.cloud_upload), label: AutoSizeText('Upload image', maxLines: 1, overflow: TextOverflow.ellipsis,), onPressed: this.uploadImage,)
         ],
       ),
    );*/
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              /*decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: const [Color(0xFFfbab66), Color(0xFFf7418c)],
                  stops: const [0.0, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                )
              ),*/
              color: Color(0xFFf7418c),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)
                  ),
                  icon: Icon(Icons.photo_album),
                  label: Text(
                    'Choose from gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0
                    ),
                  ),
                  onPressed: this.accessGallery,
                  elevation: 5.0,
                )
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.blue,
              child: Center(
                child: RaisedButton.icon(
                  icon: Icon(Icons.camera),
                  onPressed: this.accessCamera,
                  elevation: 5.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0),
                  ),
                  label: Text(
                    'Take photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0
                    ),
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}