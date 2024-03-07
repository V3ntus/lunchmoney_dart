import 'package:lunchmoney/src/api/models/_base.dart';

class Tag implements LunchMoneyModel {
  /// Unique identifier for tag.
  @override
  final int id;

  /// User-defined name of tag.
  final String name;

  /// User-defined description of tag.
  final String? description;

  /// Whether the tag will not show up when creating or updating transactions
  /// in the Lunch Money app.
  final bool archived;

  /// Construct a [Tag] object.
  Tag({
    required this.id,
    required this.name,
    required this.description,
    required this.archived,
  });

  /// Construct a [Tag] from [data].
  static fromJson(Map<String, dynamic> data) => Tag(
        id: data["id"],
        name: data["name"],
        description: data["description"],
        archived: data["archived"] ?? false,
      );
}
