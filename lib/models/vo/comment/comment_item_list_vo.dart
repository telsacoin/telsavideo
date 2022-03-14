class CommentItemListVo {
  CommentItemListVo({
    required this.statusCode,
    required this.comments,
    required this.cursor,
    required this.hasMore,
    required this.replyStyle,
    required this.total,
    required this.extra,
    required this.logPb,
    required this.topGifts,
    required this.aliasCommentDeleted,
  });
  int? statusCode;
  List<Comments>? comments;
  int? cursor;
  int? hasMore;
  int? replyStyle;
  int? total;
  Extra? extra;
  LogPb? logPb;
  List<dynamic>? topGifts;
  bool? aliasCommentDeleted;

  CommentItemListVo.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    comments =
        List.from(json['comments']).map((e) => Comments.fromJson(e)).toList();
    cursor = json['cursor'];
    hasMore = json['has_more'];
    replyStyle = json['reply_style'];
    total = json['total'];
    extra = Extra.fromJson(json['extra']);
    logPb = LogPb.fromJson(json['log_pb']);
    topGifts = List.castFrom<dynamic, dynamic>(json['top_gifts']);
    aliasCommentDeleted = json['alias_comment_deleted'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['comments'] = comments?.map((e) => e.toJson()).toList();
    _data['cursor'] = cursor;
    _data['has_more'] = hasMore;
    _data['reply_style'] = replyStyle;
    _data['total'] = total;
    _data['extra'] = extra?.toJson();
    _data['log_pb'] = logPb?.toJson();
    _data['top_gifts'] = topGifts;
    _data['alias_comment_deleted'] = aliasCommentDeleted;
    return _data;
  }
}

class Comments {
  Comments({
    required this.cid,
    required this.text,
    required this.awemeId,
    required this.createTime,
    required this.diggCount,
    required this.status,
    required this.user,
    required this.replyId,
    required this.userDigged,
    this.replyComment,
    required this.textExtra,
    required this.replyCommentTotal,
    required this.replyToReplyId,
    required this.isAuthorDigged,
    required this.stickPosition,
    required this.userBuried,
    this.labelList,
    required this.authorPin,
    required this.noShow,
    required this.collectStat,
  });
  String? cid;
  String? text;
  String? awemeId;
  int? createTime;
  int? diggCount;
  int? status;
  User? user;
  String? replyId;
  int? userDigged;
  Null replyComment;
  List<dynamic>? textExtra;
  int? replyCommentTotal;
  String? replyToReplyId;
  bool? isAuthorDigged;
  int? stickPosition;
  bool? userBuried;
  Null labelList;
  bool? authorPin;
  bool? noShow;
  int? collectStat;

  Comments.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    text = json['text'];
    awemeId = json['aweme_id'];
    createTime = json['create_time'];
    diggCount = json['digg_count'];
    status = json['status'];
    user = User.fromJson(json['user']);
    replyId = json['reply_id'];
    userDigged = json['user_digged'];
    replyComment = null;
    textExtra = List.castFrom<dynamic, dynamic>(json['text_extra']);
    replyCommentTotal = json['reply_comment_total'];
    replyToReplyId = json['reply_to_reply_id'];
    isAuthorDigged = json['is_author_digged'];
    stickPosition = json['stick_position'];
    userBuried = json['user_buried'];
    labelList = null;
    authorPin = json['author_pin'];
    noShow = json['no_show'];
    collectStat = json['collect_stat'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cid'] = cid;
    _data['text'] = text;
    _data['aweme_id'] = awemeId;
    _data['create_time'] = createTime;
    _data['digg_count'] = diggCount;
    _data['status'] = status;
    _data['user'] = user?.toJson();
    _data['reply_id'] = replyId;
    _data['user_digged'] = userDigged;
    _data['reply_comment'] = replyComment;
    _data['text_extra'] = textExtra;
    _data['reply_comment_total'] = replyCommentTotal;
    _data['reply_to_reply_id'] = replyToReplyId;
    _data['is_author_digged'] = isAuthorDigged;
    _data['stick_position'] = stickPosition;
    _data['user_buried'] = userBuried;
    _data['label_list'] = labelList;
    _data['author_pin'] = authorPin;
    _data['no_show'] = noShow;
    _data['collect_stat'] = collectStat;
    return _data;
  }
}

class User {
  User({
    required this.uid,
    required this.nickname,
    required this.avatarThumb,
    required this.customVerify,
    required this.uniqueId,
    required this.enterpriseVerifyReason,
    this.followersDetail,
    this.platformSyncInfo,
    this.geofencing,
    this.coverUrl,
    this.itemList,
    this.typeLabel,
    this.adCoverUrl,
    this.relativeUsers,
    this.chaList,
    required this.secUid,
    this.needPoints,
    this.homepageBottomToast,
    this.canSetGeofencing,
    this.whiteCoverUrl,
    this.userTags,
    this.boldFields,
    this.searchHighlight,
    this.mutualRelationAvatars,
    this.events,
  });
  String? uid;
  String? nickname;
  AvatarThumb? avatarThumb;
  String? customVerify;
  String? uniqueId;
  String? enterpriseVerifyReason;
  Null followersDetail;
  Null platformSyncInfo;
  Null geofencing;
  Null coverUrl;
  Null itemList;
  Null typeLabel;
  Null adCoverUrl;
  Null relativeUsers;
  Null chaList;
  String? secUid;
  Null needPoints;
  Null homepageBottomToast;
  Null canSetGeofencing;
  Null whiteCoverUrl;
  Null userTags;
  Null boldFields;
  Null searchHighlight;
  Null mutualRelationAvatars;
  Null events;

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nickname = json['nickname'];
    avatarThumb = AvatarThumb.fromJson(json['avatar_thumb']);
    customVerify = json['custom_verify'];
    uniqueId = json['unique_id'];
    enterpriseVerifyReason = json['enterprise_verify_reason'];
    followersDetail = null;
    platformSyncInfo = null;
    geofencing = null;
    coverUrl = null;
    itemList = null;
    typeLabel = null;
    adCoverUrl = null;
    relativeUsers = null;
    chaList = null;
    secUid = json['sec_uid'];
    needPoints = null;
    homepageBottomToast = null;
    canSetGeofencing = null;
    whiteCoverUrl = null;
    userTags = null;
    boldFields = null;
    searchHighlight = null;
    mutualRelationAvatars = null;
    events = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uid'] = uid;
    _data['nickname'] = nickname;
    _data['avatar_thumb'] = avatarThumb?.toJson();
    _data['custom_verify'] = customVerify;
    _data['unique_id'] = uniqueId;
    _data['enterprise_verify_reason'] = enterpriseVerifyReason;
    _data['followers_detail'] = followersDetail;
    _data['platform_sync_info'] = platformSyncInfo;
    _data['geofencing'] = geofencing;
    _data['cover_url'] = coverUrl;
    _data['item_list'] = itemList;
    _data['type_label'] = typeLabel;
    _data['ad_cover_url'] = adCoverUrl;
    _data['relative_users'] = relativeUsers;
    _data['cha_list'] = chaList;
    _data['sec_uid'] = secUid;
    _data['need_points'] = needPoints;
    _data['homepage_bottom_toast'] = homepageBottomToast;
    _data['can_set_geofencing'] = canSetGeofencing;
    _data['white_cover_url'] = whiteCoverUrl;
    _data['user_tags'] = userTags;
    _data['bold_fields'] = boldFields;
    _data['search_highlight'] = searchHighlight;
    _data['mutual_relation_avatars'] = mutualRelationAvatars;
    _data['events'] = events;
    return _data;
  }
}

class AvatarThumb {
  AvatarThumb({
    required this.uri,
    required this.urlList,
  });
  String? uri;
  List<String>? urlList;

  AvatarThumb.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    urlList = List.castFrom<dynamic, String>(json['url_list']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uri'] = uri;
    _data['url_list'] = urlList;
    return _data;
  }
}

class Extra {
  Extra({
    required this.now,
    this.fatalItemIds,
  });
  int? now;
  Null fatalItemIds;

  Extra.fromJson(Map<String, dynamic> json) {
    now = json['now'];
    fatalItemIds = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['now'] = now;
    _data['fatal_item_ids'] = fatalItemIds;
    return _data;
  }
}

class LogPb {
  LogPb({
    required this.imprId,
  });
  String? imprId;

  LogPb.fromJson(Map<String, dynamic> json) {
    imprId = json['impr_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['impr_id'] = imprId;
    return _data;
  }
}
