import 'package:lunchmoney/src/enums.dart';

class Crypto {
  /// Unique identifier for a manual crypto account (no ID for synced accounts)
  final int? id;

  /// Unique identifier for a synced crypto account (no ID for manual accounts,
  /// multiple currencies may have the same zabo_account_id)
  final int? zaboAccountID;

  /// The import source of the [Crypto] account.
  final CryptoSource source;

  /// Name of the crypto asset.
  final String name;

  /// Display name of the crypto asset (as set by user).
  final String displayName;

  /// Current balance
  final double balance;

  /// Date/time the balance was last updated.
  final DateTime balanceAsOf;

  /// Abbreviation for the cryptocurrency
  final String currency;

  /// The current status of the crypto account.
  final CryptoStatus status;

  /// Name of the provider holding the asset.
  final String institutionName;

  /// Datetime the asset was created.
  final DateTime createdAt;

  Crypto({
    required this.id,
    required this.zaboAccountID,
    required this.source,
    required this.name,
    required this.displayName,
    required this.balance,
    required this.balanceAsOf,
    required this.currency,
    required this.status,
    required this.institutionName,
    required this.createdAt,
  });

  static Crypto fromJson(Map<String, dynamic> data) {
    return Crypto(
      id: data["id"],
      zaboAccountID: data["zabo_account_id"],
      source: CryptoSource.fromString(data["source"]),
      name: data["name"],
      displayName: data["display_name"],
      balance: double.parse(data["balance"]),
      balanceAsOf: DateTime.parse(data["balance_as_of"]),
      currency: data["currency"],
      status: CryptoStatus.fromString(data["status"]),
      institutionName: data["institution_name"],
      createdAt: DateTime.parse(data["created_at"]),
    );
  }
}
