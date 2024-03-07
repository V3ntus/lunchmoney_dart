import 'package:lunchmoney/src/client.dart';

abstract class LunchMoneyBase {
  /// The current [LunchMoney] instance.
  final LunchMoney lunchMoney;

  LunchMoneyBase(this.lunchMoney);
}