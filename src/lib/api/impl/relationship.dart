import 'dart:async';

import 'package:telsavideo/api/relationship.dart';
import 'package:telsavideo/models/models.dart';
import 'package:telsavideo/services/requestor.dart';

class SteemRelationshipsApiImpl implements SteemRelationshipsApi {
  static const String _followingRoot = '/get_following';
  static const String _followersRoot = '/get_followers';

  final Map<String, SteemRelationshipsApiUser> _users = {};
  final Requestor requestor;

  SteemRelationshipsApiImpl(this.requestor);

  @override
  SteemRelationshipsApiUser toUser(String username) {
    return _users.putIfAbsent(username,
        () => new _SteemRelationshipsApiUserImpl(requestor, username));
  }

  @override
  Future<List<Relationship>> getFollowing(String follower,
      {int? limit, String? startFollowing, String? followType}) {
    var req = '$_followingRoot?follower=$follower';
    if (startFollowing == null) startFollowing = "NULL";
    if (followType == null) followType = "blog";
    if (limit == null) limit = 16;
    return requestor
        .request('sjs',
            '$req&startFollowing=$startFollowing&followType=$followType&limit=$limit')
        .then((r) {
      return r.data.map((m) => new Relationship.fromJson(m)).toList();
    });
  }

  @override
  Future<List<Relationship>> getFollowers(String following,
      {int? limit, String? startFollower, String? followType}) {
    var req = '$_followersRoot?following=$following';
    if (startFollower == null) startFollower = "NULL";
    if (followType == null) followType = "blog";
    if (limit == null) limit = 16;
    return requestor
        .request('sjs',
            '$req&startFollower=$startFollower&followType=$followType&limit=$limit')
        .then((r) {
      return r.data.map((m) => new Relationship.fromJson(m)).toList();
    });
  }
}

class _SteemRelationshipsApiUserImpl implements SteemRelationshipsApiUser {
  String _root = '';
  final Requestor requestor;

  _SteemRelationshipsApiUserImpl(this.requestor, String username) {
    _root = "/api/broadcast";
  }

  @override
  Future<bool> modify(String action, String target, String me, {String? what}) {
    if (action == "unfollow")
      what = "";
    else if (what == null) what = "blog";
    var modifyOperation = '[["custom_json", {'
        'required_auths": [],'
        '"required_posting_auths": [$me],'
        '"id": "follow",'
        '"json": "[\"follow\",{\"follower\":\"$me\",\"following\":\"$target\",\"what\":[\"$what\"]}]"}]]';

    return requestor.request('sc', _root,
        method: 'POST', body: {"operations": modifyOperation}).then((r) {
      return true;
    });
  }

  @override
  Future<bool> ignore(String target, String me) {
    // TODO Fix $me
    var ignoreOperation = '[["custom_json", {'
        'required_auths": [],'
        '"required_posting_auths": [$me],'
        '"id": "follow",'
        '"json": "[\"follow\",{\"follower\":\"$me\",\"following\":\"$target\",\"what\":[\"ignore\"]}]"}]]';

    return requestor.request('sc', _root,
        method: 'POST', body: {"operations": ignoreOperation}).then((r) {
      return true;
    });
  }
}
