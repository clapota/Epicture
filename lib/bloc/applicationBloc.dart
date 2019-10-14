import 'package:epicture/objects/OAuthAccessToken.dart';

import 'bloc.dart';
import 'dart:async';

class ApplicationBloc implements BlocBase {
  OAuthAccessToken token;

  StreamController<OAuthAccessToken> tokenController = StreamController<OAuthAccessToken>.broadcast();
  StreamSink<OAuthAccessToken> get addToken => tokenController.sink;
  Stream<OAuthAccessToken> get outToken => tokenController.stream;

  StreamController actionController = StreamController.broadcast();
  StreamSink get registerToken => actionController.sink;

  ApplicationBloc() {
    actionController.stream.listen(handleLogic);
  }

  void handleLogic(data) {
    token = data;
    addToken.add(token);
  }

  @override
  void dispose() {
    actionController.close();
    tokenController.close();
  }
}