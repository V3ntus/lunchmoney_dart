import 'package:lunchmoney/src/api/_base.dart';
import 'package:lunchmoney/src/api/models/tag.dart';

/// A route class holding helper methods to send tags requests to the API.
///
/// Reference: https://lunchmoney.dev/#tags
class TagsRoute extends LunchMoneyBaseRoute {
  TagsRoute(super.lunchMoney);

  /// Use this endpoint to get a list of all tags associated with the user's account.
  ///
  /// Reference: https://lunchmoney.dev/#get-all-tags
  Future<List<Tag>> get tags async => ((await lunchMoney.http.request("GET", "/tags")) as List<Map<String, dynamic>>)
      .map((e) => Tag.fromJson(e))
      .toList();
}
