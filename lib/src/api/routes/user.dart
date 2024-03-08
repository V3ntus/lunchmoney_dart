import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/user.dart';

/// A route class holding helper methods to send user requests to the API.
///
/// Reference: https://lunchmoney.dev/#user
class UserRoute extends LunchMoneyBaseRoute {
  UserRoute(super.lunchMoney);

  /// Use this endpoint to get details on the current user.
  ///
  /// Reference: https://lunchmoney.dev/#get-user
  Future<User> get me async => User.fromJson(await lunchMoney.http.request("GET", "/me"));
}