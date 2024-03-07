import 'package:lunchmoney/src/client.dart';

abstract class LunchMoneyBaseRoute {
  /// The current [LunchMoney] instance.
  final LunchMoney lunchMoney;

  LunchMoneyBaseRoute(this.lunchMoney);
}