import 'dart:async';

import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/constants.dart';
import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/api/models/asset.dart';

/// A route class holding helper methods to send asset requests to the API.
///
/// Reference: https://lunchmoney.dev/#assets
class AssetRoute extends LunchMoneyBaseRoute {
  AssetRoute(super.lunchMoney);

  /// Use this endpoint to get a list of all manually-managed assets associated with the user's account.
  ///
  /// Reference: https://lunchmoney.dev/#get-all-assets
  Future<List<Asset>> get assets async =>
      ((await lunchMoney.http.request("GET", "/assets"))["assets"] as List<Map<String, dynamic>>)
          .map((e) => Asset.fromJson(e))
          .toList();

  /// Use this endpoint to create a single (manually-managed) asset.
  /// `subtype` must not be more than 25 characters.
  /// `name` must not be more than 45 characters.
  /// `currency` must be a valid ISO4217 short code.
  ///
  /// Reference: https://lunchmoney.dev/#create-asset
  Future<Asset> createAsset({
    required AssetType type,
    required String name,
    required double balance,
    String? subtype,
    String? displayName,
    DateTime? balanceAsOf,
    String? currency,
    String? institutionName,
    DateTime? closedOn,
    bool excludeTransactions = false,
  }) async {
    if (subtype != null && subtype.length > 25) {
      throw ArgumentError.value(subtype, "subtype", "Subtype name cannot be more than 25 characters");
    }

    if (name.length > 45) {
      throw ArgumentError.value(name, "name", "Name cannot be more than 45 characters");
    }

    validateCurrency(currency);

    final json = {
      "type_name": type.value,
      "name": name,
      "balance": balance.toString(),
      "subtype_name": subtype,
      "display_name": displayName,
      "balance_as_of": balanceAsOf?.toIso8601String(),
      "currency": currency,
      "institution_name": institutionName,
      "closed_on": closedOn?.toIso8601String(),
      "exclude_transactions": excludeTransactions,
    };

    final response = await lunchMoney.http.request("POST", "/assets", json: json);
    return Asset.fromJson(response);
  }

  /// Use this endpoint to update a single asset.
  ///
  /// Reference: https://lunchmoney.dev/#update-asset
  Future<Asset> updateAsset(
    int id, {
    AssetType? type,
    String? name,
    double? balance,
    String? subtype,
    String? displayName,
    DateTime? balanceAsOf,
    String? currency,
    String? institutionName,
    DateTime? closedOn,
    bool? excludeTransactions,
  }) async {
    if (subtype != null && subtype.length > 25) {
      throw ArgumentError.value(subtype, "subtype", "Subtype name cannot be more than 25 characters");
    }

    if (name != null && name.length > 45) {
      throw ArgumentError.value(name, "name", "Name cannot be more than 45 characters");
    }

    validateCurrency(currency);

    final json = {
      "type_name": type?.value,
      "name": name,
      "balance": balance?.toString(),
      "subtype_name": subtype,
      "display_name": displayName,
      "balance_as_of": balanceAsOf?.toIso8601String(),
      "currency": currency,
      "institution_name": institutionName,
      "closed_on": closedOn?.toIso8601String(),
      "exclude_transactions": excludeTransactions,
    };

    final response = await lunchMoney.http.request("PUT", "/assets/:$id", json: json);
    return Asset.fromJson(response);
  }
}
