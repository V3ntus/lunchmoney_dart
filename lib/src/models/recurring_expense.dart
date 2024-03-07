import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/models/_base.dart';

class RecurringExpense implements LunchMoneyModel {
  /// Unique identifier for recurring expense.
  @override
  final int id;

  /// Denotes when recurring expense starts occurring. If null, then this recurring expense
  /// will show up for all time before end_date.
  final DateTime? startDate;

  /// Denotes when recurring expense stops occurring. If null, then this recurring expense has
  /// no set end date and will show up for all months after start_date
  final DateTime? endDate;

  /// Cadence of recurring expense.
  final Cadence cadence;

  /// Payee of the recurring expense.
  final String payee;

  /// Amount of the recurring expense in numeric format to 4 decimal places.
  final double amount;

  /// Three-letter lowercase currency code for the recurring expense in ISO 4217 format.
  final String currency;

  /// If any, represents the user-entered description of the recurring expense.
  final String? description;

  /// Expected billing date for this recurring expense for this month.
  final DateTime billingDate;

  /// The type of recurring expense. Can be either cleared or suggested.
  final RecurringType type;

  /// If any, represents the original name of the recurring expense as denoted by the transaction
  /// that triggered its creation.
  final String? originalName;

  /// The recurring item source.
  final RecurringSource source;

  /// If any, denotes the plaid account associated with the creation of this recurring expense (see Plaid Accounts).
  final int? plaidAccountID;

  /// If any, denotes the manually-managed account (i.e. asset) associated with the
  /// creation of this recurring expense (see Assets).
  final int? assetID;

  /// If any, denotes the unique identifier for the associated transaction matching
  /// this recurring expense for the current time period.
  final int? transactionID;

  /// If any, denotes the unique identifier for the associated category to this recurring expense
  final int? categoryID;

  /// The date and time of when the recurring expense was created.
  final DateTime createdAt;

  RecurringExpense({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.cadence,
    required this.payee,
    required this.amount,
    required this.currency,
    required this.description,
    required this.billingDate,
    required this.type,
    required this.originalName,
    required this.source,
    required this.plaidAccountID,
    required this.assetID,
    required this.transactionID,
    required this.categoryID,
    required this.createdAt,
  });

  static RecurringExpense fromJson(Map<String, dynamic> data) {
    return RecurringExpense(
      id: int.parse(data["id"]),
      startDate: DateTime.tryParse(data["start_date"]),
      endDate: DateTime.tryParse(data["end_date"]),
      cadence: Cadence.fromString(data["cadence"]),
      payee: data["payee"],
      amount: double.parse(data["amount"]),
      currency: data["currency"],
      description: data["description"],
      billingDate: DateTime.parse(data["billing_date"]),
      type: RecurringType.fromString(data["type"]),
      originalName: data["original_name"],
      source: RecurringSource.fromString(data["source"]),
      plaidAccountID: int.tryParse(data["plaid_account_id"]),
      assetID: int.tryParse(data["asset_id"]),
      transactionID: int.tryParse(data["transaction_id"]),
      categoryID: int.tryParse(data["category_id"]),
      createdAt: DateTime.parse(data["created_at"]),
    );
  }
}
