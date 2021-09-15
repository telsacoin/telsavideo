import 'package:telsavideo/models/user.dart';
import 'post.dart';
import 'relationship.dart';
import 'reply.dart';
import 'tag.dart';
import 'user.dart';
import 'vote.dart';

/// An abstraction to extract information from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemApi {
  /// This is the client's access token
  String get accessToken;

  /// The user who is logged in for this session
  User get user;

  /// An abstraction to extract post data from Steem
  SteemPostsApi get posts;

  /// An abstraction to extract relationship data from Steem
  SteemRelationshipsApi get relationships;

  /// An abstraction to extract comment data from Steem
  SteemCommentsApi get replies;

  /// An abstraction to extract tag data Steem
  SteemTagsApi get tags;

  /// An abstraction to extract user data from Steem
  SteemUsersApi get users;

  /// An abstraction to extract upvote data from Steem
  SteemVotesApi get votes;
}
