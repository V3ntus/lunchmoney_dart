import 'package:lunchmoney/src/models/_base.dart';

/// Represents the currently logged in user.
class User implements LunchMoneyModel {
  @override
  late final int id;

  /// Unique identifier for user.
  int get userID => id;

  /// User's name.
  final String userName;

  /// User's email.
  final String userEmail;

  /// Unique identifier for the associated budgeting account.
  final int accountID;

  /// Name of the associated budgeting account.
  final String budgetName;

  /// User-defined label of the developer API key used. Returns null if nothing has been set.
  final String? apiKeyLabel;

  /// Construct a [User] object.
  User({
    required int userID,
    required this.userName,
    required this.userEmail,
    required this.accountID,
    required this.budgetName,
    this.apiKeyLabel,
  }) {
    id = userID;
  }

  /// Construct a [User] object from [data].
  static fromJson(Map<String, dynamic> data) => User(
        userID: int.parse(data["user_id"]),
        userName: data["user_name"],
        userEmail: data["user_email"],
        accountID: data["account_id"],
        budgetName: data["budget_name"],
        apiKeyLabel: data["api_key_label"],
      );
}
