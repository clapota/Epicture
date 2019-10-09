class OAuthAccessToken {
  final String accessToken;
  final Duration expiresIn;
  final String tokenType;
  final String refreshToken;
  final String accountUsername;
  final String accountId;

  const OAuthAccessToken({
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.accountUsername,
    this.accountId,
  });

  factory OAuthAccessToken.fromUri(Uri uri) {
    return OAuthAccessToken.fromJson(
      Map.fromEntries(
        uri.fragment.split("&").map<MapEntry<String, String>>(
              (str) => MapEntry<String, String>(
                str.split("=").first,
                str.split("=").last,
              ),
            ),
      ),
    );
  }

  OAuthAccessToken.fromJson(Map<String, dynamic> json)
      : accessToken = json['access_token'],
        expiresIn = Duration(seconds: int.parse(json['expires_in'])),
        tokenType = json['token_type'],
        refreshToken = json['refresh_token'],
        accountUsername = json['account_username'],
        accountId = json['account_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn.inSeconds.toString();
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    data['account_username'] = accountUsername;
    data['account_id'] = accountId;
    return data;
  }
}
