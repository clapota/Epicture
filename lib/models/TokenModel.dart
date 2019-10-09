import 'package:epicture/objects/OAuthAccessToken.dart';
import 'package:scoped_model/scoped_model.dart';

class TokenModel extends Model {
  OAuthAccessToken _token = null;

  OAuthAccessToken get token => _token;

  void storeToken(OAuthAccessToken token) {
    this._token = token;
  }
}