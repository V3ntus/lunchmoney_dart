import 'package:lunchmoney/src/api/http.dart';
import 'package:lunchmoney/src/api/routes/user.dart';

/// The main Lunch Money API client class.
class LunchMoney {
  final String _accessToken;

  late final http = HTTPClient(accessToken: _accessToken);

  late final UserRoute _user;

  UserRoute get user => _user;

  LunchMoney(this._accessToken) {
    _user = UserRoute(this);
  }
}
