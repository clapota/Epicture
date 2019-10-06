import 'TextFieldWidget.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  @override
  _LoginDialog createState() => _LoginDialog();
}

class _LoginDialog extends State<LoginDialog> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    //usernameController.text
    //passwordController.text
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      title: Text('Log in', style: TextStyle(color: Colors.white)),
      children: <Widget>[
        TextFieldWidget(hintText: 'Username', visible: true, controller: this.usernameController),
        TextFieldWidget(hintText: 'Password', visible: false, controller: this.passwordController),
        Container(
          child: RaisedButton(
            elevation: 5.0,
            onPressed: login,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            child: Text('Submit'),
          ),
          padding: const EdgeInsets.fromLTRB(90, 30, 30, 0),
        )
      ],
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}