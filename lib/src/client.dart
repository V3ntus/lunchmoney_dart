import 'package:dio/dio.dart';
import 'package:lunchmoney/src/api/http.dart';
import 'package:lunchmoney/src/api/routes/asset.dart';
import 'package:lunchmoney/src/api/routes/budget.dart';
import 'package:lunchmoney/src/api/routes/category.dart';
import 'package:lunchmoney/src/api/routes/crypto.dart';
import 'package:lunchmoney/src/api/routes/plaid.dart';
import 'package:lunchmoney/src/api/routes/recurring_expense.dart';
import 'package:lunchmoney/src/api/routes/tags.dart';
import 'package:lunchmoney/src/api/routes/transactions.dart';
import 'package:lunchmoney/src/api/routes/user.dart';

/// The main Lunch Money API client class.
class LunchMoney {
  /// The HTTP handler. Normally, users shouldn't have to interact with it, but
  /// if you need to make requests, this is where you should do it.
  /// Note: The [Dio] instance is not exposed by default, but if it would
  /// be more convenient for users, a pull request is welcome.
  late final HTTPClient http;

  late final AssetRoute _asset;

  late final BudgetRoute _budget;

  late final CategoryRoute _category;

  late final CryptoRoute _crypto;

  late final PlaidRoute _plaid;

  late final RecurringExpensesRoute _recurringExpenses;

  late final TagsRoute _tags;

  late final TransactionsRoute _transactions;

  late final UserRoute _user;

  /// Make requests on the [AssetRoute] assets endpoint
  AssetRoute get assets => _asset;

  /// Make requests on the [BudgetRoute] budgets endpoint
  BudgetRoute get budgets => _budget;

  /// Make requests on the [CategoryRoute] categories endpoint
  CategoryRoute get categories => _category;

  /// Make requests on the [CryptoRoute] crypto endpoint
  CryptoRoute get crypto => _crypto;

  /// Make requests on the [PlaidRoute] Plaid endpoints
  PlaidRoute get plaid => _plaid;

  /// Make requests on the [RecurringExpensesRoute] recurring expenses endpoints
  RecurringExpensesRoute get recurring => _recurringExpenses;

  /// Make requests on the [TagsRoute] tags endpoints
  TagsRoute get tags => _tags;

  /// Make requests on the [TransactionsRoute] transactions endpoints
  TransactionsRoute get transactions => _transactions;

  /// Make requests on the [UserRoute] user endpoint
  UserRoute get user => _user;

  /// Initialize the Lunch Money API client with your access token provided.
  LunchMoney(String accessToken) {
    http = HTTPClient(accessToken: accessToken);

    // Instantiate routes
    _asset = AssetRoute(this);
    _budget = BudgetRoute(this);
    _category = CategoryRoute(this);
    _crypto = CryptoRoute(this);
    _plaid = PlaidRoute(this);
    _recurringExpenses = RecurringExpensesRoute(this);
    _tags = TagsRoute(this);
    _transactions = TransactionsRoute(this);
    _user = UserRoute(this);
  }
}
