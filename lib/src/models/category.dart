import 'package:lunchmoney/src/models/_base.dart';

/// Represents an asset category
class Category implements LunchMoneyModel {
  /// A unique identifier for the category.
  @override
  final int id;

  /// The name of the category. Must be between 1 and 40 characters.
  final String name;

  /// The description of the category. Must not exceed 140 characters.
  final String? description;

  /// If true, the transactions in this category will be treated as income.
  final bool isIncome;

  /// If true, the transactions in this category will be excluded from the budget.
  final bool excludeFromBudget;

  /// If true, the transactions in this category will be excluded from totals.
  final bool excludeFromTotals;

  /// If true, the category is archived and not displayed in relevant areas of the Lunch Money app.
  final bool? archived;

  /// The date and time of when the category was last archived.
  final DateTime? archivedOn;

  /// The date and time of when the category was last updated (in the ISO 8601 extended format).
  final DateTime? updatedAt;

  /// The date and time of when the category was created (in the ISO 8601 extended format).
  final DateTime? createdAt;

  /// If true, the category is a group that can be a parent to other categories.
  final bool isGroup;

  /// The ID of a category group (or null if the category doesn't belong to a category group).
  final int? groupID;

  /// Numerical ordering of categories.
  final int? order;

  /// For category groups, this will populate with the categories nested within and
  /// include id, name, description and created_at fields.
  final List<Category>? children;

  /// For grouped categories, the name of the category group.
  final String? groupCategoryName;

  /// Construct a [Category] object.
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.isIncome,
    required this.excludeFromBudget,
    required this.excludeFromTotals,
    required this.archived,
    required this.archivedOn,
    required this.updatedAt,
    required this.createdAt,
    required this.isGroup,
    required this.groupID,
    required this.order,
    required this.children,
    required this.groupCategoryName,
  });

  /// Construct a [Category] object from [data].
  static fromJson(Map<String, dynamic> data) => Category(
        id: int.parse(data["id"]),
        name: data["name"],
        description: data["description"],
        isIncome: data["is_income"],
        excludeFromBudget: data["exclude_from_budget"],
        excludeFromTotals: data["exclude_from_totals"],
        archived: data["archived"],
        archivedOn: DateTime.tryParse(data["archived_on"]),
        updatedAt: DateTime.tryParse(data["updated_at"]),
        createdAt: DateTime.tryParse(data["created_at"]),
        isGroup: data["is_group"],
        groupID: data["group_id"],
        order: data["order"],
        children: data.containsKey("children")
            ? <Category>[
                ...List.from(data["children"]).map((e) => Category.fromJson({
                  ...data, // inherit properties from parent
                  ...e, // override any parent properties from child
                })),
              ]
            : [],
        groupCategoryName: data["group_category_name"],
      );
}
