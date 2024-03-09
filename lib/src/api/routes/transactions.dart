import 'package:intl/intl.dart';
import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/transaction.dart';
import 'package:lunchmoney/src/enums.dart';

/// A transaction object used only to update another transaction.
///
/// Reference: https://lunchmoney.dev/#update-transaction-object
class PartialTransaction {
  /// Date of this transaction
  final DateTime? date;

  /// Unique identifier for associated category_id.
  /// Category must be associated with the same account and must not be a category group.
  final int? categoryID;

  /// Max 140 characters.
  final String? payee;

  /// You may only update this if this transaction was not created from an automatic
  /// import, i.e. if this transaction is not associated with a plaid_account_id
  final double? amount;

  /// You may only update this if this transaction was not created from an automatic import,
  /// i.e. if this transaction is not associated with a plaid_account_id. Defaults to user account's primary currency.
  final String? currency;

  /// Unique identifier for associated asset (manually-managed account). Asset must be associated
  /// with the same account. You may only update this if this transaction was not created from an
  /// automatic import, i.e. if this transaction is not associated with a plaid_account_id
  final int? assetID;

  /// Unique identifier for associated recurring expense.
  /// Recurring expense must be associated with the same account.
  final int? recurringID;

  /// Max 350 characters.
  final String? notes;

  /// Must be either cleared or uncleared. Defaults to uncleared If recurring_id is provided,
  /// the status will automatically be set to recurring or recurring_suggested depending on
  /// the type of recurring_id. Defaults to uncleared.
  final TransactionStatus? status;

  /// User-defined external ID for transaction. Max 75 characters. External IDs must be unique within the same
  /// asset_id. You may only update this if this transaction was not created from an automatic import,
  /// i.e. if this transaction is not associated with a plaid_account_id
  final int? externalID;

  /// Input must be an array, or error will be thrown. Passing in a number will attempt to match by ID. If no matching
  /// tag ID is found, an error will be thrown. Passing in a string will attempt to match by string. If no matching tag
  /// name is found, a new tag will be created. Pass in null to remove all tags.
  final List<dynamic>? tags;

  /// A transaction object used only to update another transaction.
  ///
  /// Reference: https://lunchmoney.dev/#update-transaction-object
  PartialTransaction({
    this.date,
    this.categoryID,
    this.payee,
    this.amount,
    this.currency,
    this.assetID,
    this.recurringID,
    this.notes,
    this.status = TransactionStatus.uncleared,
    this.externalID,
    this.tags = const [],
  }) {
    if ((payee?.length ?? 0) > 140) {
      throw ArgumentError.value(payee, "payee", "Payee cannot be more than 140 characters");
    }

    if ((notes?.length ?? 0) > 350) {
      throw ArgumentError.value(notes, "notes", "Notes cannot be more than 350 characters");
    }
  }

  /// A property to retrieve the JSON representation of this class.
  Map<String, dynamic> get toJson => {
        if (date != null) "date": DateFormat("yyyy-MM-dd").format(date!),
        if (categoryID != null) "category_id": categoryID,
        if (payee != null) "payee": payee,
        if (amount != null) "amount": amount,
        if (currency != null) "currency": currency,
        if (assetID != null) "asset_id": assetID,
        if (recurringID != null) "recurring_id": recurringID,
        if (notes != null) "notes": notes,
        if (status != null) "status": status!.value,
        if (externalID != null) "external_id": externalID,
        if (tags != null) "tags": tags,
      };
}

/// Defines the split of a transaction. You may not split an already-split transaction, recurring transaction,
/// or group transaction. (see Split object below). If passing an array of split objects to this parameter,
/// the transaction parameter is not required.
///
/// Reference: https://lunchmoney.dev/#split-object
class SplitTransaction {
  /// Max 140 characters. Sets to original payee if none defined.
  final String? payee;

  /// Must be in ISO 8601 format (YYYY-MM-DD). Sets to original date if none defined
  final DateTime? date;

  /// Unique identifier for associated category_id. Category must be associated with the same account.
  /// Sets to original category if none defined
  final int? categoryID;

  /// Sets to original notes if none defined.
  final String? notes;

  /// Individual amount of split. Currency will inherit from parent transaction.
  /// All amounts must sum up to parent transaction amount.
  final double amount;

  /// Defines the split of a transaction. You may not split an already-split transaction, recurring transaction,
  /// or group transaction. (see Split object below). If passing an array of split objects to this parameter,
  /// the transaction parameter is not required.
  ///
  /// Reference: https://lunchmoney.dev/#split-object
  SplitTransaction({
    required this.payee,
    required this.date,
    required this.categoryID,
    required this.notes,
    required this.amount,
  });

  /// A property to retrieve the JSON representation of this class.
  Map<String, dynamic> get toJson => {
        "amount": amount,
        if (payee != null) "payee": payee,
        if (date != null) "date": DateFormat("yyyy-MM-dd").format(date!),
        if (categoryID != null) "category_id": categoryID,
        if (notes != null) "notes": notes,
      };
}

/// A route class holding helper methods to send transactions requests to the API.
///
/// Reference: https://lunchmoney.dev/#transactions
class TransactionsRoute extends LunchMoneyBaseRoute {
  TransactionsRoute(super.lunchMoney);

  /// Use this endpoint to retrieve all transactions between a date range.
  ///
  /// Returns list of Transaction objects and a has_more indicator. If no query parameters are set,
  /// this endpoint will return transactions for the current calendar month (see start_date and end_date).
  ///
  /// [status] can be cleared or uncleared. For recurring transactions, use recurring.
  /// [startDate] denotes the beginning of the time period to fetch transactions for. Defaults to beginning of
  /// current month. Required if end_date exists.
  /// [endDate] denotes the end of the time period you'd like to get transactions for. Defaults to end of
  /// current month. Required if start_date exists.
  ///
  /// Reference: https://lunchmoney.dev/#get-all-transactions
  Future<List<Transaction>> transactions({
    int? tagID,
    int? recurringID,
    int? plaidAccountID,
    int? categoryID,
    int? assetID,
    bool? isGroup,
    TransactionStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    bool debitAsNegative = false,
    bool pending = false,
    int? offset,
    int? limit = 1000,
  }) async {
    if ((limit ?? 0) > 1000) throw ArgumentError.value(limit, "limit", "Limit cannot be more than 1000");

    if ((startDate == null && endDate != null) || (startDate != null && endDate == null)) {
      throw ArgumentError.value(
        [startDate, endDate],
        "startDate, endDate",
        "startDate and endDate both need to present or both null. One cannot be present without the other",
      );
    }

    final queryParameters = {
      if (tagID != null) "tag_id": tagID,
      if (recurringID != null) "recurring_id": recurringID,
      if (plaidAccountID != null) "plaid_account_id": plaidAccountID,
      if (categoryID != null) "category_id": categoryID,
      if (assetID != null) "asset_id": assetID,
      if (isGroup != null) "is_group": isGroup,
      if (status != null) "status": status,
      if (startDate != null) "start_date": DateFormat("yyyy-MM-dd").format(startDate),
      if (endDate != null) "end_date": DateFormat("yyyy-MM-dd").format(endDate),
      "debit_as_negative": debitAsNegative,
      "pending": pending,
      if (offset != null) "offset": offset,
      if (limit != null) "limit": limit,
    };

    final res = await lunchMoney.http.request("GET", "/transactions", queryParameters: queryParameters);
    return (res["transactions"] as List).cast<Map<String, dynamic>>().map((e) => Transaction.fromJson(e)).toList();
  }

  /// Use this endpoint to retrieve details about a specific transaction by ID.
  /// Returns a single Transaction object.
  ///
  /// Reference: https://lunchmoney.dev/#get-single-transaction
  Future<Transaction> transaction(int transactionID, {bool debitAsNegative = false}) async => (Transaction.fromJson(
        await lunchMoney.http.request(
          "GET",
          "/transactions/:$transactionID",
          queryParameters: {
            "debit_as_negative": debitAsNegative,
          },
        ),
      ));

  /// Use this endpoint to insert many transactions at once.
  /// Upon success, IDs of inserted transactions will be returned in an array.
  ///
  /// https://lunchmoney.dev/#insert-transactions
  Future<List<int>> insertTransactions({
    required List<PartialTransaction> transactions,
    bool applyRules = false,
    bool skipDuplicates = false,
    bool checkForRecurring = false,
    bool debitAsNegative = false,
    bool skipBalanceUpdate = true,
  }) async {
    final json = {
      "transactions": transactions.map((e) => e.toJson),
      "apply_rules": applyRules,
      "skip_duplicates": skipDuplicates,
      "check_for_recurring": checkForRecurring,
      "debit_as_negative": debitAsNegative,
      "skip_balance_update": skipDuplicates,
    };
    final res = await lunchMoney.http.request(
      "POST",
      "/transactions",
      json: json,
    );
    return res["ids"];
  }

  /// Use this endpoint to update a single transaction.
  /// You may also use this to split an existing transaction.
  ///
  /// https://lunchmoney.dev/#update-transaction
  Future<Map<String, dynamic>> updateTransaction(
    int transactionID, {
    List<SplitTransaction>? splits,
    PartialTransaction? transaction,
    bool debitAsNegative = false,
    bool skipBalanceUpdate = true,
  }) async {
    if ((splits == null || splits.isEmpty) && (transaction == null)) {
      throw ArgumentError.value(
        "$splits,$transaction",
        "splits,transaction",
        "Either splits or transaction should be provided. Both cannot be empty.",
      );
    }

    final json = {
      if (splits != null) "split": splits.map((e) => e.toJson),
      if (transaction != null) "transaction": transaction.toJson,
      "debit_as_negative": debitAsNegative,
      "skip_balance_update": skipBalanceUpdate,
    };

    return await lunchMoney.http.request("POST", "/transactions/:$transactionID", json: json);
  }

  /// Use this endpoint to unsplit one or more transactions.
  /// Returns an array of IDs of deleted transactions
  ///
  /// https://lunchmoney.dev/#unsplit-transactions
  Future<List<int>> unsplitTransactions(List<int> parentIDs, {bool removeParents = false}) async {
    return await lunchMoney.http.request("POST", "/transactions/unsplit", json: {
      "parent_ids": parentIDs,
      "remove_parents": removeParents,
    });
  }

  /// Use this endpoint to get the parent transaction and associated children transactions of a transaction group.
  /// Returns the hydrated parent transaction of a transaction group
  ///
  /// https://lunchmoney.dev/#get-transaction-group
  Future<Transaction> getTransactionGroup(int transactionID) async {
    return Transaction.fromJson(await lunchMoney.http.request("GET", "/transactions/group"));
  }

  /// Use this endpoint to create a transaction group of two or more transactions.
  /// Returns the ID of the newly created transaction group
  ///
  /// https://lunchmoney.dev/#create-transaction-group
  Future<int> createTransactionGroup({
    required DateTime date,
    required String payee,
    required List<int> transactions,
    int? categoryID,
    String? notes,
    List<int>? tags,
  }) async {
    return int.parse(await lunchMoney.http.request("POST", "/transactions/group", json: {
      "date": DateFormat("yyyy-MM-dd").format(date),
      "payee": payee,
      "transactions": transactions,
      "category_id": categoryID,
      "notes": notes,
      "tags": tags,
    }));
  }

  /// Use this endpoint to delete a transaction group. The transactions within the group will not be removed.
  /// Returns the IDs of the transactions that were part of the deleted group
  ///
  /// https://lunchmoney.dev/#delete-transaction-group
  Future<List<int>> deleteTransactionGroup(int transactionID) async {
    final res = await lunchMoney.http.request("DELETE", "/transactions/group/:$transactionID");
    return res["transactions"];
  }
}
