import 'dart:async';

import 'package:telsavideo/api/post.dart';
import 'package:telsavideo/models/models.dart';
import 'package:telsavideo/services/requestor.dart';

class SteemPostsApiImpl implements SteemPostsApi {
  static const String _root = '/get_content';

  final Requestor requestor;

  SteemPostsApiImpl(this.requestor);

  @override
  Future<Post> getPost(String author, String permlink) {
    return requestor
        .request('sjs', '$_root?author=$author&permlink=$permlink')
        .then((r) => new Post.fromJson(r.data));
  }
}
