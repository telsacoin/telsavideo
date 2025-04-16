import 'dart:async';

import 'package:telsavideo/models/user.dart';

/// An abstraction to extract reply information from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemCommentsApi {
  /// An abstraction to extract reply information from a single Steem post
  /// https://api.steemjs.com/get_content_replies?author=AUTHOR&permlink=PERMLINK
  SteemCommentsApiPost forPost(String author, String permlink);
}

/// An abstraction to extract reply information from a single Steem post
abstract class SteemCommentsApiPost {
  /// Get a list of recent comments on a post object
  Future<List<Reply>> getReplies();

  /// Create a comment
  /// https://steemconnect.com/sign/comment?parent_author=AUTHOR&parent_permlink=PARENT_PERMLINK&author=AUTHOR&permlink=REPLY_PERMLINK&title=TITLE&body=BODY&json_metadata=VALUE
  Future<bool> createComment(String parentAuthor, String parentPermlink,
      String author, String permlink, String title, String body,
      {String? jsonMetadata});

  /// Remove a comment either on the authenticated user's post object or authored by the authenticated user
  /// https://steemconnect.com/sign/delete_comment?author=value&permlink=value
  Future<bool> deleteComment(String author, String permlink);
}
