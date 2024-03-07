import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/models/_base.dart';

class Asset implements LunchMoneyModel {
  /// Unique identifier for asset
  @override
  final int id;

  /// Primary type of the asset.
  final AssetType type;

  /// Optional asset subtype.
  final AssetSubtype? subtype;

  /// The name of the asset.
  final String name;

  /// Display name of the asset (as set by user).
  final String? displayName;

  /// Current balance of the asset in numeric format to 4 decimal places.
  final double balance;

  /// Date/time the balance was last updated.
  final DateTime balanceAsOf;

  /// The date this asset was closed (optional).
  final DateTime? closedOn;

  /// Three-letter lowercase currency code of the balance in ISO 4217 format.
  final String currency;

  /// Name of institution holding the asset.
  final String? institutionName;

  /// If true, this asset will not show up as an option for
  /// assignment when creating transactions manually.
  final bool excludeTransactions;

  /// Date/time the asset was created.
  final DateTime createdAt;

  Asset({
    required this.id,
    required this.type,
    required this.subtype,
    required this.name,
    required this.displayName,
    required this.balance,
    required this.balanceAsOf,
    required this.closedOn,
    required this.currency,
    required this.institutionName,
    required this.excludeTransactions,
    required this.createdAt,
  });

  static Asset fromJson(Map<String, dynamic> data) {
    return Asset(
      id: data["id"],
      type: AssetType.fromString(data["type_type"]),
      subtype: data["subtype_name"] != null ? AssetSubtype.fromString(data["subtype_name"]) : null,
      name: data["name"],
      displayName: data["display_name"],
      balance: double.parse(data["balance"]),
      balanceAsOf: DateTime.parse(data["balance_as_of"]),
      closedOn: DateTime.tryParse(data["closed_on"]),
      currency: data["currency"],
      institutionName: data["institution_name"],
      excludeTransactions: data["exclude_transactions"],
      createdAt: DateTime.parse(data["created_at"]),
    );
  }
}
