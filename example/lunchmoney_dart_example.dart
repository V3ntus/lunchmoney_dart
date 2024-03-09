import 'dart:io';

import 'package:lunchmoney/lunchmoney.dart';

void main() async {
  final env = Platform.environment;

  final client = LunchMoney(env["API_KEY"]!);

  final transactions = await client.transactions.transactions(startDate: DateTime(2024, 2, 1), endDate: DateTime.now());
  print(transactions.map((e) => "${e.payee} -> ${e.amount}").join("\n"));
}
