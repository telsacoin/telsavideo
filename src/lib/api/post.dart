import 'dart:async';

import 'package:telsavideo/models/user.dart';

/// An abstraction to extract post information from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemPostsApi {
  /// Get information about a post object
  /// https://api.steemjs.com/get_content?author=AUTHOR&permlink=PERMLINK
  Future<Post> getPost(String author, String permlink);
}
