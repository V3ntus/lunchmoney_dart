import 'package:lunchmoney/src/models/transaction.dart';

/// The current status of a [Transaction]
enum TransactionStatus {
  /// User has reviewed the transaction.
  cleared,

  /// User has not yet reviewed the transaction.
  uncleared,

  /// Transaction is linked to a recurring expense.
  recurring,

  /// Transaction is listed as a suggested transaction for an existing recurring expense.
  recurringSuggested,

  /// Imported transaction is marked as pending. This should be a temporary state.
  pending;

  static TransactionStatus fromString(String value) =>
      TransactionStatus.values.singleWhere((e) => value.toLowerCase().contains(e.name));
}

/// The source of the [Transaction] when it was imported.
enum TransactionSource {
  api,
  csv,
  manual,
  merge,
  plaid,
  recurring,
  rule,
  user;

  static TransactionSource fromString(String value) =>
      TransactionSource.values.singleWhere((e) => value.toLowerCase().contains(e.name));
}

/// Cadence of associated recurring item.
enum RecurringCadence {
  weekly,
  everyTwoWeeks,
  bimonthly,
  monthly,
  everyTwoMonths,
  everyThreeMonths,
  everyFourMonths,
  biannually,
  annually,
  unknown;

  static RecurringCadence fromString(String value) {
    switch (value) {
      case "once a week":
        return RecurringCadence.weekly;
      case "every 2 weeks":
        return RecurringCadence.everyTwoWeeks;
      case "twice a month":
        return RecurringCadence.bimonthly;
      case "monthly":
        return RecurringCadence.monthly;
      case "every 2 months":
        return RecurringCadence.everyTwoMonths;
      case "every 3 months":
        return RecurringCadence.everyThreeMonths;
      case "every 4 months":
        return RecurringCadence.everyFourMonths;
      case "twice a year":
        return RecurringCadence.biannually;
      case "yearly":
        return RecurringCadence.annually;
      default:
        return RecurringCadence.unknown;
    }
  }
}

/// The recurring item type.
enum RecurringType {
  /// The recurring expense has been reviewed by the user.
  cleared,

  /// The recurring expense is suggested by the system; the user has yet to review/clear it.
  suggested,

  /// The recurring expense has been dismissed by the user.
  dismissed;

  static RecurringType fromString(String value) =>
      RecurringType.values.singleWhere((e) => value.toLowerCase().contains(e.name));
}

/// The recurring item source.
enum RecurringSource {
  /// User created this recurring expense manually from the Recurring Expenses page.
  manual,

  /// User created this by converting a transaction from the Transactions page.
  transaction,

  /// Recurring expense was created by th system on transaction import.
  system,

  /// Some older recurring expenses may not have a source
  none;

  static RecurringSource fromString(String? value) {
    if (value == null || value.isEmpty) return RecurringSource.none;
    return RecurringSource.values.singleWhere((e) => value.toLowerCase().contains(e.name));
  }
}

/// Status of associated manually-managed account.
enum AssetStatus {
  active,
  closed;

  static AssetStatus fromString(String value) =>
      AssetStatus.values.singleWhere((e) => value.toLowerCase().contains(e.name));
}
