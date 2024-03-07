import 'dart:io';

import 'package:lunchmoney/lunchmoney.dart';

void main() async {
  final env = Platform.environment;

  final client = LunchMoney(env["API_KEY"]!);

  print((await client.user.me).userName);
}
