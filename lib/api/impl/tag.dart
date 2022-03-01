import 'dart:async';

import 'package:telsavideo/models/user.dart';

import 'package:telsavideo/api/tag.dart';
import 'package:telsavideo/services/requestor.dart';

class SteemTagsApiImpl implements SteemTagsApi {
  static const String _trendingRoot = '/get_trending_tags';
  static const String _authorTagsRoot = '/get_tags_used_by_author';
  // ignore: unused_field
  static const int _limit = 10;
  final Requestor requestor;

  SteemTagsApiImpl(this.requestor);

  @override
  Future<List<Tag>> getTrendingTags({int? limit}) {
    var req = '$_trendingRoot?';

    if (limit != null) req += '&limit=$limit';
    if (limit == null) req += '&limit=10';

    return requestor.request('sjs', '$req').then((r) {
      return r.data.map((m) => new Tag.fromJson(m)).toList();
    });
  }

  @override
  Future<List<dynamic>> getTagsUsedByAuthor(String author) {
    return requestor
        .request('sjs', '$_authorTagsRoot?&author=$author')
        .then((r) {
      return r.data.map((m) => new Tag.fromJson(m)).toList();
    });
  }
}
