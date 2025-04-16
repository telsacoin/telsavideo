import 'dart:async';

import 'package:telsavideo/models/user.dart';

/// An abstraction to extract user data from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemUsersApi {
  /// Get data about the owner of the access token
  SteemUsersApiSelf get self;

  /// Get information about a user
  /// https://api.steemjs.com/get_accounts?names=['USERNAME']
  Future<User> getByUsername(String username);

  /// Get information about mulitple users
  /// https://api.steemjs.com/get_accounts?names=['USERNAME', 'USER', '..']
  Future<List<User>> getUsers(List<String> usernames);

  /// Get information about currently authenticated user
  /// https://v2.steemconnect.com/api/me
  Future<User> getSelf();

  /// Get the most recent media published by a user
  /// https://api.steemjs.com/get_blog?account=USERNAME&entryId=ENTRYID&limit=LIMIT
  Future<List<Post>> getPosts(String username, {int entryId, int limit});

  /// Get the list of posts upvoted by a given user
  /// https://api.steemjs.com/get_account_votes?voter=USER
  Future<List<PostVote>> getVotedPosts(String username);

  /// Get a list of users matching the query
  /// https://api.steemjs.com/lookup_accounts?lowerBoundName=username&limit=LIMIT
  Future<List<String>> search(String query, {int? limit});
}

/// An abstraction to extract information about the owner of the access token
abstract class SteemUsersApiSelf {
  /// Get information about the owner of the access token
  Future<User> get();

  /// Get the most recent media published by the owner of the access token
  /// https://api.steemjs.com/get_blog?account=USERNAME&entry_id=ENTRYID&limit=LIMIT
  Future<List<Post>> getOwnPosts(String username, {int entryId, String limit});

  /// Get the list of recent posts upvoted by the owner of the access token
  /// https://api.steemjs.com/get_account_votes?voter=USER
  Future<List<PostVote>> getVotedPosts(String username);

  /// Get a list of recent posts published by the users followed by the authenticated user
  /// https://api.steemjs.com/get_feed?account=ACCOUNT&limit=16
  Future<List<Post>> getFeed(String account, {int? limit});
}
