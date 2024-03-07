import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/http.dart';
import 'package:lunchmoney/src/api/models/category.dart';

/// A route class holding helper methods to send category requests to the API.
class CategoryRoute extends LunchMoneyBaseRoute {
  CategoryRoute(super.lunchMoney);

  /// Use this endpoint to get a flattened list of all categories in
  /// alphabetical order associated with the user's account.
  Future<List<Category>> get categories async =>
      ((await lunchMoney.http.request("GET", "/categories"))["categories"] as List<Map<String, dynamic>>)
          .map((e) => Category.fromJson(e))
          .toList();

  /// Use this endpoint to get hydrated details on a single category.
  /// Note that if this category is part of a category group, its properties
  /// (is_income, exclude_from_budget, exclude_from_totals) will inherit from the category group.
  Future<Category> category(int categoryID) async => Category.fromJson(
        ((await lunchMoney.http.request("GET", "/categories/:$categoryID"))["categories"] as Map<String, dynamic>),
      );

  /// Use this endpoint to create a single category. Returns the ID of the category provided.
  Future<int> createCategory(
      {required String name,
      String? description,
      bool isIncome = false,
      bool excludeFromBudget = false,
      bool excludeFromTotals = false,
      bool archived = false,
      int? groupID}) async {
    if (name.length > 45 || name.isEmpty) {
      throw ArgumentError.value(name, "name", "Name must be between 1 and 40 characters.");
    }

    if (description != null && description.length > 140) {
      throw ArgumentError.value(description, "description", "Description cannot be more than 140 characters.");
    }

    final json = {
      "name": name,
      "description": description,
      "is_income": isIncome,
      "exclude_from_budget": excludeFromBudget,
      "exclude_from_totals": excludeFromTotals,
      "archived": archived,
      "group_id": groupID,
    };

    final response = await lunchMoney.http.request("POST", "/categories", json: json);
    return int.parse(response["category_id"]);
  }

  /// Use this endpoint to update the properties for a single category or category group.
  Future<bool> updateCategory(int categoryID,
      {String? name,
      String? description,
      bool? isIncome,
      bool? excludeFromBudget,
      bool? excludeFromTotals,
      bool? archived,
      int? groupID}) async {
    if (name != null && (name.length > 45 || name.isEmpty)) {
      throw ArgumentError.value(name, "name", "Name must be between 1 and 40 characters.");
    }

    if (description != null && description.length > 140) {
      throw ArgumentError.value(description, "description", "Description cannot be more than 140 characters.");
    }

    final json = {
      "name": name,
      "description": description,
      "is_income": isIncome,
      "exclude_from_budget": excludeFromBudget,
      "exclude_from_totals": excludeFromTotals,
      "archived": archived,
      "group_id": groupID,
    };

    final response = await lunchMoney.http.request("PUT", "/categories/:$categoryID", json: json);
    return response.toString().contains("true");
  }

  /// Use this endpoint to create a single category group.
  ///
  /// [categoryIDs] is an array of category_id to include in the category group.
  ///
  /// [categoryNames] is an array of strings representing new categories to create and
  /// subsequently include in the category group.
  Future<int> createCategoryGroup({
    required String name,
    String? description,
    bool isIncome = false,
    bool excludeFromBudget = false,
    bool excludeFromTotals = false,
    List<int>? categoryIDs,
    List<String>? categoryNames,
  }) async {
    final json = {
      "name": name,
      "description": description,
      "is_income": isIncome,
      "exclude_from_budget": excludeFromBudget,
      "exclude_from_totals": excludeFromTotals,
      "category_ids": categoryIDs,
      "new_categories": categoryNames,
    };

    final response = await lunchMoney.http.request("POST", "/categories", json: json);
    return int.parse(response["category_id"]);
  }

  /// Use this endpoint to add categories (either existing or new) to a single category group.
  ///
  /// [categoryIDs] is an array of category_id to include in the category group.
  ///
  /// [categoryNames] is an array of strings representing new categories to create and
  /// subsequently include in the category group.
  Future<Category> addToCategoryGroup(
    int groupID, {
    List<int>? categoryIDs,
    List<String>? categoryNames,
  }) async =>
      Category.fromJson(await lunchMoney.http.request(
        "POST",
        "/categories/group/:$groupID/add",
        json: {
          "category_ids": categoryIDs,
          "new_categories": categoryNames,
        },
      ));

  /// Use this endpoint to delete a single category or category group.
  /// This will only work if there are no dependencies, such as existing budgets for the category,
  /// categorized transactions, categorized recurring items, etc.
  /// If there are dependents, this endpoint will return what the dependents are and how many there are.
  ///
  /// If [force] is true, the API will disassociate the category from any transactions, recurring items, budgets, etc.
  /// Note: it is best practice to first try the Delete Category endpoint to ensure you don't accidentally
  /// delete any data. Disassociation/deletion of the data arising from this endpoint is irreversible!
  ///
  /// Returns true if successfully deleted, otherwise returns the dependents object below (if [force] is false):
  ///
  /// ```json
  /// {
  ///   "dependents": {
  ///     "category_name": "Food & Drink",
  ///     "budget": 4,
  ///     "category_rules": 0,
  ///     "transactions": 43,
  ///     "children": 7,
  ///     "recurring": 0
  ///   }
  /// }
  /// ```
  ///
  /// Throws [UnknownResponseError] if the response is anything else.
  Future<dynamic> deleteCategory(int categoryID, {bool force = false}) async {
    final res = await lunchMoney.http.request("DELETE", "/categories/:$categoryID${force ? "/force" : ""}");

    // Return expected results
    if (res.toString().trim().toLowerCase() == "true") return true;
    if (res is Map<String, dynamic>) return res;

    // Throw error if unexpected result.
    throw UnknownResponseError("Unexpected response from API: $res");
  }
}
