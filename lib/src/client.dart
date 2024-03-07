import 'package:dio/dio.dart';
import 'package:lunchmoney/src/api/http.dart';
import 'package:lunchmoney/src/api/routes/asset.dart';
import 'package:lunchmoney/src/api/routes/user.dart';

/// The main Lunch Money API client class.
class LunchMoney {
  /// The HTTP handler. Normally, users shouldn't have to interact with it, but
  /// if you need to make requests, this is where you should do it.
  /// Note: The [Dio] instance is not exposed by default, but if it would
  /// be more convenient for users, a pull request is welcome.
  late final HTTPClient http;

  late final UserRoute _user;

  late final AssetRoute _asset;

  /// Make requests on the [UserRoute] user endpoint
  UserRoute get user => _user;

  /// Make requests on the [AssetRoute] assets endpoint
  AssetRoute get assets => _asset;

  /// Initialize the Lunch Money API client with your access token provided.
  LunchMoney(String accessToken) {
    http = HTTPClient(accessToken: accessToken);

    // Instantiate routes
    _user = UserRoute(this);
    _asset = AssetRoute(this);
  }
}
