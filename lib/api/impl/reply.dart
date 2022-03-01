import 'dart:async';

import 'package:telsavideo/api/reply.dart';
import 'package:telsavideo/models/user.dart';
import 'package:telsavideo/services/requestor.dart';

class SteemCommentsApiImpl implements SteemCommentsApi {
  final Map<String, SteemCommentsApiPost> _posts = {};
  final Requestor requestor;

  SteemCommentsApiImpl(this.requestor);

  @override
  SteemCommentsApiPost forPost(String author, String permlink) {
    Map<String, String> _postData = {"author": author, "permlink": permlink};
    return _posts.putIfAbsent(_postData.toString(),
        () => new _SteemCommentsApiPostImpl(author, permlink, requestor));
  }
}

class _SteemCommentsApiPostImpl implements SteemCommentsApiPost {
  final String author;
  final String permlink;
  final Requestor requestor;
  String? _getRepliesRoot;
  String? _root;

  _SteemCommentsApiPostImpl(this.author, this.permlink, this.requestor) {
    _getRepliesRoot = '/get_content_replies?author=$author&permlink=$permlink';
    _root = '/api/broadcast';
  }

  @override
  Future<List<Reply>> getReplies() {
    return requestor.request('sjs', _getRepliesRoot!).then((r) {
      return r.data.map((m) => new Reply.fromJson(m)).toList();
    });
  }

  @override
  Future<bool> createComment(String parentAuthor, String parentPermlink,
      String author, String permlink, String title, String body,
      {String? jsonMetadata}) {
    var commentOperation = '[["comment", {'
        '"parent_author": "$parentAuthor",'
        '"parent_permlink": "$parentPermlink",'
        '"author": "$author",'
        '"permlink": "$permlink",'
        '"title": "$title",'
        '"body": "$body",'
        '"json_metadata": "$jsonMetadata.toString()"}]]';

    return requestor.request('sc', _root!,
        method: 'POST', body: {"operations": commentOperation}).then((r) {
      return true;
    });
  }

  Future<bool> deleteComment(String author, String permlink) {
    var deleteOperation = '"operations": ['
        '["delete_comment", {'
        '"author": "$author",'
        '"permlink": "$permlink"}]]';
    return requestor.request('sc', _root!,
        method: 'POST', body: {"operations": deleteOperation}).then((r) {
      return true;
    });
  }
}
