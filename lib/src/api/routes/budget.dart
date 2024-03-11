import 'package:intl/intl.dart';
import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/constants.dart';
import 'package:lunchmoney/src/api/models/budget.dart';

/// A route class holding helper methods to send budget requests to the API.
///
/// Reference: https://lunchmoney.dev/#budget
class BudgetRoute extends LunchMoneyBaseRoute {
  BudgetRoute(super.lunchMoney);

  /// Use this endpoint to get full details on the budgets for all budget-able categories between a certain time period.
  /// The budgeted and spending amounts will be broken down by month.
  /// Lunch Money currently only supports monthly budgets, so your [startDate] and [endDate]
  /// should be the start and end of a month. (2024-04-01, 2024-04-30).
  /// [currency] should be a valid ISO4217 short code.
  ///
  /// Reference: https://lunchmoney.dev/#get-budget-summary
  Future<List<Budget>> budgets(DateTime startDate, DateTime endDate, {String? currency}) async {
    if (endDate.isBefore(startDate)) {
      throw ArgumentError.value(endDate, "endDate", "End date cannot be before start date");
    }

    validateCurrency(currency);

    final List<dynamic> res = await lunchMoney.http.request("GET", "/budgets", queryParameters: {
      "start_date": DateFormat('yyyy-MM-dd').format(startDate),
      "end_date": DateFormat('yyyy-MM-dd').format(endDate),
      if (currency != null) "currency": currency,
    });
    return List<Map<String, dynamic>>.from(res).map<Budget>((e) => Budget.fromJson(e)).toList();
  }

  /// Use this endpoint to update an existing budget or insert a new budget for a particular category and date.
  ///
  /// Lunch Money currently only supports monthly budgets, so your [startDate]
  /// should be the start of a month. (2024-04-01).
  ///
  /// If this is a sub-category, the response will include the updated category group's budget.
  /// This is because setting a sub-category may also update the category group's overall budget.
  ///
  /// [currency] should be a valid ISO4217 short code.
  ///
  /// Reference: https://lunchmoney.dev/#upsert-budget
  Future<Map<String, dynamic>> upsertBudget({
    required DateTime startDate,
    required int categoryID,
    required double amount,
    String? currency,
  }) async {
    validateCurrency(currency);

    final json = <String, dynamic>{
      "start_date": DateFormat('yyyy-MM-dd').format(startDate),
      "category_id": categoryID,
      "amount": amount,
      "currency": currency,
    };

    final Map<String, dynamic> res = await lunchMoney.http.request("PUT", "/budgets", json: json);
    return res;
  }

  /// Use this endpoint to unset an existing budget for a particular category in a particular month.
  ///
  /// Reference: https://lunchmoney.dev/#remove-budget
  Future<bool> deleteBudget(DateTime startDate, int categoryID) async {
    return await lunchMoney.http.request("DELETE", "/budgets", queryParameters: {
      "start_date": DateFormat('yyyy-MM-dd').format(startDate),
      "category_id": categoryID,
    })
      ..toString().contains("true");
  }
}
