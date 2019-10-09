import 'package:epicture/ImgurAPI.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class LoginPage extends StatefulWidget {
  const LoginPage({ Key key}) : super(key: key);


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color(0xFFfbab66), Color(0xFFf7418c)],
            stops: const [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Center(
                child: Title(
                  child: Text(
                  'Epicture',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                color: Colors.lime)
              ),
             // color: Colors.lime,
              margin: const EdgeInsets.fromLTRB(65, 150, 65, 40),
            ),
            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                border: Border.all(color: Colors.white),
                color: Colors.white
              ),
              child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  url_launcher.launch(Uri.https(
                    ImgurAPI.authorizationEndpoint.authority,
                    ImgurAPI.authorizationEndpoint.path,
                    {
                      'client_id': ImgurAPI.clientId,
                      'response_type': 'token',
                    },
                  ).toString());
                  Navigator.pop(context);
                },
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0)
                ),
                child: Text(
                  'Log in',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0
                  ),
                ),
              ),
              margin: const EdgeInsets.fromLTRB(30, 80, 30, 0)
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                margin: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(color: Colors.white),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  )
                )
              )
            )
          ],
        )
      )
    );
  }
}