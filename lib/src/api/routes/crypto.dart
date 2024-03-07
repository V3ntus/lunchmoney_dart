import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/crypto.dart';

class CryptoRoute extends LunchMoneyBaseRoute {
  CryptoRoute(super.lunchMoney);

  /// Use this endpoint to get a list of all cryptocurrency assets associated with the user's account.
  /// Both crypto balances from synced and manual accounts will be returned.
  Future<List<Crypto>> get crypto async =>
      ((await lunchMoney.http.request("GET", "/crypto"))["crypto"] as List<Map<String, dynamic>>)
          .map((e) => Crypto.fromJson(e))
          .toList();

  /// Use this endpoint to update a single manually-managed crypto asset (does not include assets received from
  /// syncing with your wallet/exchange/etc). These are denoted by source: manual from the GET call above.
  Future<Crypto> update(
    int id, {
    String? name,
    String? displayName,
    String? institutionName,
    double? balance,
    String? currency,
  }) async {
    final json = <String, dynamic>{
      "name": name,
      "display_name": displayName,
      "institution_name": institutionName,
      "balance": balance.toString(),
      "currency": currency,
    };

    final res = await lunchMoney.http.request("PUT", "/crypto/manual/:$id", json: json);
    return Crypto.fromJson(res);
  }
}
