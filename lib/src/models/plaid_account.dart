import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/models/_base.dart';

class PlaidAccount implements LunchMoneyModel {
  /// Unique identifier of the Plaid account
  @override
  final int id;

  /// Date account was first linked.
  final DateTime dateLinked;

  /// Name of the account. Can be overridden by the user.
  /// Field is originally set by Plaid
  final String name;

  /// Display name of the account, if not set it will return a
  /// concatenated string of institution and account name.
  final String displayName;

  /// Primary type of account.
  /// This field is set by Plaid and cannot be altered.
  final PlaidAccountType type;

  /// Optional subtype name of account.
  /// This field is set by Plaid and cannot be altered.
  final String subtype;

  /// Mask (last 3 to 4 digits of account) of account.
  /// This field is set by Plaid and cannot be altered
  final int mask;

  /// Name of institution associated with account. This field is set by Plaid and cannot be altered.
  final String institutionName;

  /// Current balance of the account in numeric format to 4 decimal places.
  /// This field is set by Plaid and cannot be altered
  final double balance;

  /// Currency of account balance in ISO 4217 format.
  /// This field is set by Plaid and cannot be altered
  final String currency;

  /// Date balance was last updated.
  /// This field is set by Plaid and cannot be altered
  final DateTime balanceLastUpdate;

  /// Optional credit limit of the account.
  /// This field is set by Plaid and cannot be altered
  final double? limit;

  /// Date of earliest date allowed for importing transactions.
  /// Transactions earlier than this date are not imported.
  final DateTime? importStartDate;

  /// Timestamp in ISO 8601 extended format of the last time Lunch
  /// Money imported new data from Plaid for this account.
  final DateTime? lastImport;

  /// Timestamp in ISO 8601 extended format of the last successful
  /// check from Lunch Money for updated data or timestamps from Plaid
  /// in ISO 8601 extended format (not necessarily date of last successful import)
  final DateTime? lastFetch;

  /// Timestamp in ISO 8601 extended format of the last time Plaid
  /// successfully connected with institution for new transaction updates,
  /// regardless of whether any new data was available in the update.
  final DateTime plaidLastSuccessfulUpdate;

  PlaidAccount({
    required this.id,
    required this.dateLinked,
    required this.name,
    required this.displayName,
    required this.type,
    required this.subtype,
    required this.mask,
    required this.institutionName,
    required this.balance,
    required this.currency,
    required this.balanceLastUpdate,
    required this.limit,
    required this.importStartDate,
    required this.lastImport,
    required this.lastFetch,
    required this.plaidLastSuccessfulUpdate,
  });

  static PlaidAccount fromJson(Map<String, dynamic> data) {
    return PlaidAccount(
      id: data["id"],
      dateLinked: DateTime.parse(data["date_linked"]),
      name: data["name"],
      displayName: data["display_name"],
      type: PlaidAccountType.fromString(data["type"]),
      subtype: data["subtype"],
      mask: int.parse(data["mask"]),
      institutionName: data["institution_name"],
      balance: double.parse(data["balance"]),
      currency: data["currency"],
      balanceLastUpdate: DateTime.parse(data["balance_last_update"]),
      limit: data["limit"],
      importStartDate: DateTime.tryParse(data["import_start_date"]),
      lastImport: DateTime.tryParse(data["last_import"]),
      lastFetch: DateTime.tryParse(data["last_fetch"]),
      plaidLastSuccessfulUpdate: DateTime.parse(data["plaid_last_successful_update"]),
    );
  }
}
