import 'package:intl/intl.dart';
import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/recurring_expense.dart';

class RecurringExpensesRoute extends LunchMoneyBaseRoute {
  RecurringExpensesRoute(super.lunchMoney);

  /// Use this endpoint to retrieve a list of recurring expenses to expect for a specified period.
  ///
  /// Every month, a different set of recurring expenses is expected. This is because recurring expenses can be
  /// once a year, twice a year, every 4 months, etc.
  ///
  /// If a recurring expense is listed as “twice a month”, then that recurring expense will be returned twice,
  /// each with a different billing date based on when the system believes that recurring expense transaction is to
  /// be expected. If the recurring expense is listed as “once a week”, then that recurring expense will be returned
  /// in this list as many times as there are weeks for the specified month.
  ///
  /// In the same vein, if a recurring expense that began last month is set to “Every 3 months”, then that recurring
  /// expense will not show up in the results for this month.
  ///
  /// [startDate] Accepts a string in ISO-8601 short format. Whatever your start date, the system will automatically
  /// return recurring expenses expected for that month. For instance, if you input 2020-01-25, the system will return
  /// recurring expenses which are to be expected between 2020-01-01 to 2020-01-31.
  ///
  /// [debitAsNegative] should be true if you’d like expenses to be returned as negative amounts
  /// and credits as positive amounts.
  Future<List<RecurringExpense>> recurringExpenses({
    DateTime? startDate,
    bool debitAsNegative = false,
  }) async =>
      ((await lunchMoney.http.request(
        "GET",
        "/recurring_expenses",
        json: {
          "start_date": startDate != null ? DateFormat("yyyy-MM-dd").format(startDate) : null,
          "debit_as_negative": debitAsNegative,
        },
      ))["recurring_expenses"] as List<Map<String, dynamic>>)
          .map((e) => RecurringExpense.fromJson(e))
          .toList();
}
