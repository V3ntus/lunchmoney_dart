import 'package:lunchmoney/src/enums.dart';
import 'package:lunchmoney/src/api/models/_base.dart';

class Budget implements LunchMoneyModel {
  @override
  int get id => throw UnimplementedError();

  /// Name of the category, will be "Uncategorized" if no category is assigned.
  final String categoryName;

  /// Unique identifier for category, can be null when category_name is "Uncategorized"
  final int? categoryID;

  /// Name of the category group, if applicable.
  final String? categoryGroupName;

  /// Unique identifier for category group
  final int? groupID;

  /// If true, this category is a group
  final bool? isGroup;

  /// If true, this category is an income category
  /// (category properties are set in the app via the Categories page)
  final bool isIncome;

  /// If true, this category is excluded from budget (category properties
  /// are set in the app via the Categories page)
  final bool excludeFromBudget;

  /// If true, this category is excluded from totals (category properties
  /// are set in the app via the Categories page)
  final bool excludeFromTotals;

  /// For each month with budget or category spending data, there is a data
  /// object with the key set to the month in format YYYY-MM-DD. For properties, see Data object below.
  final Map<DateTime, BudgetData> data;

  /// Object representing the category's budget suggestion configuration.
  final BudgetConfig? config;

  /// Numerical ordering of budgets.
  final int order;

  /// True if the category is archived and not displayed in relevant areas of the Lunch Money app.
  final bool archived;

  /// Returns a list object that contains an array of Recurring Expenses objects
  /// (just the payee, amount, currency, and to_base fields) that affect this budget.
  final List<BudgetPartialRecurring>? recurring;

  Budget({
    required this.categoryName,
    required this.categoryID,
    required this.categoryGroupName,
    required this.groupID,
    required this.isGroup,
    required this.isIncome,
    required this.excludeFromBudget,
    required this.excludeFromTotals,
    required this.data,
    required this.config,
    required this.order,
    required this.archived,
    required this.recurring,
  });

  static Budget fromJson(Map<String, dynamic> data) {
    return Budget(
      categoryName: data["category_name"],
      categoryID: data["category_id"],
      categoryGroupName: data["category_group_name"],
      groupID: data["group_id"],
      isGroup: data["is_group"],
      isIncome: data["is_income"],
      excludeFromBudget: data["exclude_from_budget"],
      excludeFromTotals: data["exclude_from_totals"],
      data: Map.fromEntries((data["data"] as Map<String, Map>? ?? <String, Map>{})
          .entries
          .map((e) => MapEntry(DateTime.parse(e.key), BudgetData.fromJson(e.value as Map<String, dynamic>)))),
      config: data["config"] != null ? BudgetConfig.fromJson(data["config"]) : null,
      order: data["order"],
      archived: data["archived"],
      recurring: (data["recurring"]["list"] as List<Map<String, dynamic>>? ?? <Map<String, dynamic>>[])
          .map((e) => BudgetPartialRecurring.fromJson(e))
          .toList(),
    );
  }
}

class BudgetData {
  /// The budget amount, as set by the user. If empty, no budget has been set.
  final double? budgetAmount;

  /// The budget currency, as set by the user. If empty, no budget has been set.
  final String? budgetCurrency;

  /// The budget converted to the user's primary currency. If the multicurrency
  /// feature is not being used, budget_to_base and budget_amount will be the same. If empty, no budget has been set.
  final double? budgetToBase;

  /// The total amount spent in this category for this time period in the user's primary currency
  final double spendingToBase;

  /// Number of transactions that make up "spending_to_base"
  final int numTransactions;

  /// If true, the budget_amount is only a suggestion based on the set config. If not present,
  /// it is false (meaning this is a locked in budget)
  final bool isAutomated;

  BudgetData({
    required this.budgetAmount,
    required this.budgetCurrency,
    required this.budgetToBase,
    required this.spendingToBase,
    required this.numTransactions,
    required this.isAutomated,
  });

  static BudgetData fromJson(Map<String, dynamic> data) {
    return BudgetData(
      budgetAmount: data["budget_amount"],
      budgetCurrency: data["budget_currency"],
      budgetToBase: data["budget_to_base"],
      spendingToBase: data["spending_to_base"],
      numTransactions: data["num_transactions"],
      isAutomated: data["is_automated"] ?? false,
    );
  }
}

class BudgetConfig {
  /// Unique identifier for config.
  final int configID;

  /// The budget cadence.
  final Cadence cadence;

  /// Amount in numeric format.
  final double amount;

  /// Three-letter lowercase currency code for the recurring expense in ISO 4217 format.
  final String currency;

  /// The amount converted to the user's primary currency.
  final double toBase;

  /// The auto-suggested budget config type.
  final BudgetSuggest autoSuggest;

  BudgetConfig({
    required this.configID,
    required this.cadence,
    required this.amount,
    required this.currency,
    required this.toBase,
    required this.autoSuggest,
  });

  static BudgetConfig fromJson(Map<String, dynamic> data) {
    return BudgetConfig(
      configID: int.parse(data["config_id"]),
      cadence: Cadence.fromString(data["cadence"]),
      amount: data["amount"],
      currency: data["currency"],
      toBase: data["to_base"],
      autoSuggest: BudgetSuggest.fromString(data["auto_suggest"]),
    );
  }
}

class BudgetPartialRecurring {
  final String payee;

  final double amount;

  final String currency;

  final double toBase;

  BudgetPartialRecurring({
    required this.payee,
    required this.amount,
    required this.currency,
    required this.toBase,
  });

  static BudgetPartialRecurring fromJson(Map<String, dynamic> data) {
    return BudgetPartialRecurring(
      payee: data["payee"],
      amount: double.parse(data["amount"]),
      currency: data["currency"],
      toBase: data["to_base"],
    );
  }
}
