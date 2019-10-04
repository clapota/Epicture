import 'TextFieldWidget.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key key}) : super(key: key);

  void login() {

  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('Log in', style: TextStyle(color: Colors.white)),
      children: <Widget>[
        TextFieldWidget(hintText: 'Username', visible: true),
        TextFieldWidget(hintText: 'Password', visible: false),
        Container(
          child: RaisedButton.icon(
            onPressed: login,
            label: Text('Submit'),
            icon: Image.asset('assets/imgur.png', width: 30, height: 30),
          ),
          padding: const EdgeInsets.fromLTRB(70, 30, 30, 0),
        )
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}