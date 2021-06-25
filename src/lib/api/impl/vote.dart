import 'dart:async';

import 'package:telsavideo/api/vote.dart';
import 'package:telsavideo/models/models.dart';
import 'package:telsavideo/services/requestor.dart';

class SteemVotesApiImpl implements SteemVotesApi {
  final Map<String, SteemVotesApiPost> _posts = {};
  final Requestor requestor;

  SteemVotesApiImpl(this.requestor);

  @override
  SteemVotesApiPost forPost(String author, String permlink) {
    Map<String, String> _postData = {"author": author, "permlink": permlink};
    return _posts.putIfAbsent(_postData.toString(),
        () => new _SteemVotesApiPostImpl(author, permlink, requestor));
  }
}

class _SteemVotesApiPostImpl implements SteemVotesApiPost {
  final String? author;
  final String? permlink;
  final Requestor? requestor;
  String? _votersRoot;
  String? _voteRoot;

  _SteemVotesApiPostImpl(this.author, this.permlink, this.requestor) {
    _votersRoot = '/get_active_votes';
    _voteRoot = '/api/broadcast';
  }

  @override
  Future<List<ActiveVote>> getVoters(String author, String permlink) {
    var req = '$_votersRoot?author=$author&permlink=$permlink';

    return requestor!.request('sjs', req).then((r) {
      return r.data.map((m) => new ActiveVote.fromJson(m)).toList();
    });
  }

  @override
  Future<bool> upvote(String voter, String author, String permlink,
      {int? weight}) {
    // ignore: unnecessary_null_comparison
    if (weight == null) weight = 10000; // 100% as default
    var voteOperation = '[["vote", {'
        '"voter": "$voter",'
        '"author": "$author",'
        '"permlink": "$permlink",'
        '"weight": "$weight"}]]';

    return requestor!.request('sc', _voteRoot!,
        method: 'POST', body: {"operations": voteOperation}).then((r) {
      return true;
    });
  }

  @override
  Future<bool> unvote(String voter, String author, String permlink) {
    var unvoteOperation = '[["vote", {'
        '"voter": "$voter",'
        '"author": "$author",'
        '"permlink": "$permlink",'
        '"weight": "0"}]]';

    return requestor!.request('sc', _voteRoot!,
        method: 'POST', body: {"operations": unvoteOperation}).then((r) {
      return true;
    });
  }
}
