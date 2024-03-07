import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/models/user.dart';

class UserRoute extends LunchMoneyBase {
  UserRoute(super.lunchMoney);

  /// Use this endpoint to get details on the current user.
  Future<User> get me async => User.fromJson(await lunchMoney.http.request("GET", "/me"));
}