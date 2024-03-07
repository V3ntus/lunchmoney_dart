import 'package:lunchmoney/src/api/http.dart';
import 'package:lunchmoney/src/api/routes/asset.dart';
import 'package:lunchmoney/src/api/routes/user.dart';

/// The main Lunch Money API client class.
class LunchMoney {
  late final HTTPClient http;

  late final UserRoute _user;

  late final AssetRoute _asset;

  UserRoute get user => _user;

  AssetRoute get assets => _asset;

  LunchMoney(String accessToken) {
    http = HTTPClient(accessToken: accessToken);

    // Instantiate routes
    _user = UserRoute(this);
    _asset = AssetRoute(this);
  }
}
