import 'package:lunchmoney/src/models/transaction.dart';
import 'package:lunchmoney/src/models/asset.dart';

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
enum Cadence {
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

  static Cadence fromString(String value) {
    switch (value) {
      case "once a week":
        return Cadence.weekly;
      case "every 2 weeks":
        return Cadence.everyTwoWeeks;
      case "twice a month":
        return Cadence.bimonthly;
      case "monthly":
        return Cadence.monthly;
      case "every 2 months":
        return Cadence.everyTwoMonths;
      case "every 3 months":
        return Cadence.everyThreeMonths;
      case "every 4 months":
        return Cadence.everyFourMonths;
      case "twice a year":
        return Cadence.biannually;
      case "yearly":
        return Cadence.annually;
      default:
        return Cadence.unknown;
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

/// Primary type of the [Asset]
enum AssetType {
  cash,
  credit,
  investment,
  realEstate,
  loan,
  vehicle,
  cryptocurrency,
  employeeCompensation,
  otherLiability,
  otherAsset,
  unknown;

  static AssetType fromString(String value) {
    switch (value) {
      case "cash":
        return AssetType.cash;
      case "credit":
        return AssetType.credit;
      case "investment":
        return AssetType.investment;
      case "real estate":
        return AssetType.realEstate;
      case "loan":
        return AssetType.loan;
      case "vehicle":
        return AssetType.vehicle;
      case "cryptocurrency":
        return AssetType.cryptocurrency;
      case "employee compensation":
        return AssetType.employeeCompensation;
      case "other liability":
        return AssetType.otherLiability;
      case "other asset":
        return AssetType.otherAsset;
      default:
        return AssetType.unknown;
    }
  }
}

/// An optional [Asset] subtype
enum AssetSubtype {
  retirement,
  checking,
  savings,
  prepaidCreditCard,
  unknown;

  static AssetSubtype fromString(String value) {
    switch (value) {
      case "retirement":
        return AssetSubtype.retirement;
      case "checking":
        return AssetSubtype.checking;
      case "savings":
        return AssetSubtype.savings;
      case "prepaid credit card":
        return AssetSubtype.prepaidCreditCard;
      default:
        return AssetSubtype.unknown;
    }
  }
}

/// Status of associated manually-managed account.
enum AssetStatus {
  active,
  closed;

  static AssetStatus fromString(String value) =>
      AssetStatus.values.singleWhere((e) => value.toLowerCase().contains(e.name));
}

enum BudgetSuggest {
  budgeted,
  fixed,
  fixedRollover,
  spent,
  unknown;

  static BudgetSuggest fromString(String value) {
    switch (value) {
      case "budgeted":
        return BudgetSuggest.budgeted;
      case "fixed":
        return BudgetSuggest.fixed;
      case "fixed-rollover":
        return BudgetSuggest.fixedRollover;
      case "spent":
        return BudgetSuggest.spent;
      default:
        return BudgetSuggest.unknown;
    }
  }
}
