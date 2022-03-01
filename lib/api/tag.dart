import 'dart:async';

import 'package:telsavideo/models/user.dart';

/// An abstraction to extract tag data from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemTagsApi {
  /// Get information about trending categories
  /// https://api.steemjs.com/get_trending_tags?&limit=5
  Future<List<Tag>> getTrendingTags({int limit});

  /// Get tags used by an author
  /// https://api.steemjs.com/get_tags_used_by_author?author=AUTHOR
  Future<List<dynamic>> getTagsUsedByAuthor(String author);
}
