import 'package:intl/intl.dart';
import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/plaid_account.dart';

/// A route class holding helper methods to send Plaid account requests to the API.
///
/// Reference: https://lunchmoney.dev/#plaid-accounts
class PlaidRoute extends LunchMoneyBaseRoute {
  PlaidRoute(super.lunchMoney);

  /// Use this endpoint to get a list of all synced Plaid accounts associated with the user's account.
  ///
  /// Plaid Accounts are individual bank accounts that you have linked to Lunch Money via Plaid.
  /// You may link one bank but one bank might contain 4 accounts. Each of these accounts is a Plaid Account.
  ///
  /// Reference: https://lunchmoney.dev/#get-all-plaid-accounts
  Future<List<PlaidAccount>> get plaidAccounts async =>
      ((await lunchMoney.http.request("GET", "/plaid_accounts"))["plaid_accounts"] as List<Map<String, dynamic>>)
          .map((e) => PlaidAccount.fromJson(e))
          .toList();

  /// This is an experimental endpoint and parameters and/or response may change.
  ///
  /// Use this endpoint to trigger a fetch for latest data from Plaid.
  /// Returns true if there were eligible Plaid accounts to trigger a fetch for. Eligible accounts are those who
  /// last_fetch value is over 1 minute ago. (Although the limit is every minute, please use this endpoint sparingly!).
  ///
  /// Note that fetching from Plaid is a background job. This endpoint simply queues up the job. You may track the
  /// plaid_last_successful_update, last_fetch and last_import properties to verify the results of the fetch.
  ///
  /// Reference: https://lunchmoney.dev/#trigger-fetch-from-plaid
  Future<bool> triggerFetch({DateTime? startDate, DateTime? endDate, int? plaidAccountID}) async {
    final json = {
      "start_date": startDate != null ? DateFormat("yyyy-MM-dd").format(startDate) : null,
      "end_date": endDate != null ? DateFormat("yyyy-MM-dd").format(endDate) : null,
      "plaid_account_id": plaidAccountID,
    };
    final res = await lunchMoney.http.request("POST", "/plaid_accounts/fetch", json: json);
    return res.toString().toLowerCase() == "true";
  }
}
