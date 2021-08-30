import 'dart:async';

import 'package:telsavideo/api/user.dart';
import 'package:telsavideo/models/user.dart';
import 'package:telsavideo/services/requestor.dart';

const String _accountsRoot = '/get_accounts';
const String _selfRoot = '/api/me';
const String _blogRoot = '/get_blog';
const String _searchRoot = '/lookup_accounts';
const String _votesRoot = '/get_account_votes';
const String _feedRoot = '/get_feed';
String me = 'amigos'; // TODO Lol gotta fix this

class SteemUsersApiImpl implements SteemUsersApi {
  _SteemUsersApiSelfImpl? _self;
  final Requestor requestor;

  SteemUsersApiImpl(this.requestor);

  @override
  SteemUsersApiSelf get self =>
      _self ??= new _SteemUsersApiSelfImpl(this, requestor);

  @override
  Future<User> getByUsername(String username) {
    return requestor
        .request('sjs', '$_accountsRoot?names=["$username"]')
        .then((r) => new User.fromJson(r.data));
  }

  @override
  Future<User> getSelf() {
    return requestor
        .request('sc', '$_selfRoot')
        .then((r) => new User.fromJson(r.data));
  }

  @override
  Future<List<User>> getUsers(List<String> usernames) {
    return requestor
        .request('sjs', '$_accountsRoot?names=$usernames')
        .then((r) {
      return r.data.map((m) => new User.fromJson(m)).toList();
    });
  }

  @override
  Future<List<Post>> getPosts(String username, {int? entryId, int? limit}) {
    var req = '$_blogRoot?account=$username';

    if (entryId != null) req += '&entry_id=$entryId';
    if (limit != null)
      req += '$limit=$limit';
    else if (limit == null) req += '$limit=16';

    return requestor.request('sjs', req).then((r) {
      return r.data.map((m) => new Post.fromJson(m)).toList();
    });
  }

  @override
  Future<List<PostVote>> getVotedPosts(String username) {
    return requestor.request('sjs', '$_votesRoot?voter=$username').then((r) {
      return r.data.map((m) => new PostVote.fromJson(m)).toList();
    });
  }

  @override
  Future<List<String>> search(String query, {int? limit}) {
    var req = '$_searchRoot/?lowerBoundName=$query';

    if (limit != null)
      req += '&limit=$limit';
    else if (limit == null) req += '&limit=16';

    return requestor.request('sjs', req).then((r) {
      return r.data.map((m) => new User.fromJson(m)).toList();
    });
  }
}

class _SteemUsersApiSelfImpl implements SteemUsersApiSelf {
  final SteemUsersApiImpl parent;
  final Requestor requestor;

  _SteemUsersApiSelfImpl(this.parent, this.requestor);

  @override
  Future<User> get() => parent.getSelf();

  // TODO: Fix $me
  @override
  Future<List<Post>> getOwnPosts(String username,
      {int? entryId, String? limit}) {
    var req = '$_blogRoot?account=$username';
    String _entryId = entryId.toString();
    if (entryId != null) req += '&entry_id=$_entryId';
    if (limit != null)
      req += '&limit=$limit';
    else if (limit == null) req += '&limit=16';

    return requestor.request('sjs', '$req').then((r) {
      return r.data.map((m) => new Post.fromJson(m)).toList();
    });
  }

  // TODO: Fix $me
  Future<List<PostVote>> getVotedPosts(String username) {
    return requestor.request('sjs', '$_votesRoot?voter=$username').then((r) {
      return r.data.map((m) => new PostVote.fromJson(m)).toList();
    });
  }

  Future<List<Post>> getFeed(String account, {int? limit}) {
    var req = '$_feedRoot?account=$account';

    if (limit != null)
      req += '&limit=$limit';
    else if (limit == null) req += '&limit=16';

    return requestor.request('sjs', req).then((r) {
      return r.data.map((m) => new Post.fromJson(m)).toList();
    });
  }
}
