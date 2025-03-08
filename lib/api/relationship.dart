import 'dart:async';

import 'package:telsavideo/models/user.dart';

/// An abstraction to extract relationship information from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemRelationshipsApi {
  /// Get the list of users this user follows
  ///
  /// follower - Name of the target
  /// startFollowing - Used for pagination
  /// followType - Usually 'blog'
  /// limit - Limit the number of matches returned
  ///
  /// https://api.steemjs.com/get_following?follower=NAME&startFollowing=NULL&followType=TYPE&limit=LIMIT
  Future<List<Relationship>> getFollowing(String follower,
      {int? limit, String? startFollowing, String? followType});

  /// Get the list of users this user is followed by
  ///
  /// following - Name of the target
  /// startFollower - Used for pagination
  /// followType - Usually 'blog'
  /// limit - Limit the number of matches returned
  ///
  /// https://api.steemjs.com/get_followers?following=NAME&startFollower=NULL&followType=TYPE&limit=LIMIT
  Future<List<Relationship>> getFollowers(String following,
      {int? limit, String? startFollower, String? followType});

  SteemRelationshipsApiUser toUser(String username);
}

abstract class SteemRelationshipsApiUser {
  /// Modify the relationship between the currently authenticated user and the target user
  ///
  /// You will need to include an [action] as a parameter to specify the action you wish to perform.
  /// Valid actions: 'follow', 'unfollow'
  /// `what` is set to 'blog' by default, unless a value is provided
  Future<bool> modify(String action, String target, String me, {String what});

  Future<bool> ignore(String target, String me);
}
