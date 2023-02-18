class CommentListReplyVo {
  CommentListReplyVo({
    required this.total,
    required this.extra,
    required this.logPb,
    required this.statusCode,
    required this.comments,
    required this.cursor,
    required this.hasMore,
  });
  late final int total;
  late final Extra extra;
  late final LogPb logPb;
  late final int statusCode;
  late final List<Comments> comments;
  late final int cursor;
  late final int hasMore;

  CommentListReplyVo.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    extra = Extra.fromJson(json['extra']);
    logPb = LogPb.fromJson(json['log_pb']);
    statusCode = json['status_code'];
    comments =
        List.from(json['comments']).map((e) => Comments.fromJson(e)).toList();
    cursor = json['cursor'];
    hasMore = json['has_more'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total'] = total;
    _data['extra'] = extra.toJson();
    _data['log_pb'] = logPb.toJson();
    _data['status_code'] = statusCode;
    _data['comments'] = comments.map((e) => e.toJson()).toList();
    _data['cursor'] = cursor;
    _data['has_more'] = hasMore;
    return _data;
  }
}

class Extra {
  Extra({
    required this.now,
    required this.fatalItemIds,
    required this.logid,
  });
  late final int now;
  late final List<dynamic> fatalItemIds;
  late final String logid;

  Extra.fromJson(Map<String, dynamic> json) {
    now = json['now'];
    fatalItemIds = List.castFrom<dynamic, dynamic>(json['fatal_item_ids']);
    logid = json['logid'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['now'] = now;
    _data['fatal_item_ids'] = fatalItemIds;
    _data['logid'] = logid;
    return _data;
  }
}

class LogPb {
  LogPb({
    required this.imprId,
  });
  late final String imprId;

  LogPb.fromJson(Map<String, dynamic> json) {
    imprId = json['impr_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['impr_id'] = imprId;
    return _data;
  }
}

class Comments {
  Comments({
    this.diggCount,
    required this.user,
    required this.isAuthorDigged,
    required this.userBuried,
    required this.transBtnStyle,
    required this.cid,
    required this.replyId,
    this.replyComment,
    this.noShow,
    required this.awemeId,
    required this.status,
    required this.textExtra,
    required this.replyToReplyId,
    this.labelList,
    this.text,
    required this.createTime,
    required this.userDigged,
    this.collectStat,
  });
  late final int? diggCount;
  late final User? user;
  late final bool? isAuthorDigged;
  late final bool? userBuried;
  late final int? transBtnStyle;
  late final String? cid;
  late final String? replyId;
  late final ReplyComment? replyComment;
  late final bool? noShow;
  late final String awemeId;
  late final int? status;
  late final int textExtra;
  late final String replyToReplyId;
  late final String? labelList;
  late final String? text;
  late final int? createTime;
  late final int userDigged;
  late final int? collectStat;

  Comments.fromJson(Map<String, dynamic> json) {
    diggCount = null;
    user = json['user'];
    isAuthorDigged = json['is_author_digged'];
    userBuried = json['user_buried'];
    transBtnStyle = json['trans_btn_style'];
    cid = json['cid'];
    replyId = json['reply_id'];
    replyComment = null;
    noShow = null;
    awemeId = json['aweme_id'];
    status = json['status'];
    textExtra = json['text_extra'];
    replyToReplyId = json['reply_to_reply_id'];
    labelList = null;
    text = null;
    createTime = json['create_time'];
    userDigged = json['user_digged'];
    collectStat = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['digg_count'] = diggCount;
    _data['user'] = user;
    _data['is_author_digged'] = isAuthorDigged;
    _data['user_buried'] = userBuried;
    _data['trans_btn_style'] = transBtnStyle;
    _data['cid'] = cid;
    _data['reply_id'] = replyId;
    _data['reply_comment'] = replyComment;
    _data['no_show'] = noShow;
    _data['aweme_id'] = awemeId;
    _data['status'] = status;
    _data['text_extra'] = textExtra;
    _data['reply_to_reply_id'] = replyToReplyId;
    _data['label_list'] = labelList;
    _data['text'] = text;
    _data['create_time'] = createTime;
    _data['user_digged'] = userDigged;
    _data['collect_stat'] = collectStat;
    return _data;
  }
}

class User {
  User({
    this.searchHighlight,
    this.followersDetail,
    this.platformSyncInfo,
    required this.customVerify,
    required this.uniqueId,
    required this.enterpriseVerifyReason,
    this.coverUrl,
    this.itemList,
    this.homepageBottomToast,
    required this.nickname,
    required this.avatarThumb,
    this.mutualRelationAvatars,
    this.events,
    this.chaList,
    this.needPoints,
    this.canSetGeofencing,
    this.whiteCoverUrl,
    this.userTags,
    this.geofencing,
    this.relativeUsers,
    this.adCoverUrl,
    required this.secUid,
    this.boldFields,
    this.advanceFeatureItemOrder,
    required this.uid,
    this.typeLabel,
  });
  late final Null searchHighlight;
  late final Null followersDetail;
  late final Null platformSyncInfo;
  late final String customVerify;
  late final String uniqueId;
  late final String enterpriseVerifyReason;
  late final Null coverUrl;
  late final Null itemList;
  late final Null homepageBottomToast;
  late final String nickname;
  late final AvatarThumb avatarThumb;
  late final Null mutualRelationAvatars;
  late final Null events;
  late final Null chaList;
  late final Null needPoints;
  late final Null canSetGeofencing;
  late final Null whiteCoverUrl;
  late final Null userTags;
  late final Null geofencing;
  late final Null relativeUsers;
  late final Null adCoverUrl;
  late final String secUid;
  late final Null boldFields;
  late final Null advanceFeatureItemOrder;
  late final String uid;
  late final Null typeLabel;

  User.fromJson(Map<String, dynamic> json) {
    searchHighlight = null;
    followersDetail = null;
    platformSyncInfo = null;
    customVerify = json['custom_verify'];
    uniqueId = json['unique_id'];
    enterpriseVerifyReason = json['enterprise_verify_reason'];
    coverUrl = null;
    itemList = null;
    homepageBottomToast = null;
    nickname = json['nickname'];
    avatarThumb = AvatarThumb.fromJson(json['avatar_thumb']);
    mutualRelationAvatars = null;
    events = null;
    chaList = null;
    needPoints = null;
    canSetGeofencing = null;
    whiteCoverUrl = null;
    userTags = null;
    geofencing = null;
    relativeUsers = null;
    adCoverUrl = null;
    secUid = json['sec_uid'];
    boldFields = null;
    advanceFeatureItemOrder = null;
    uid = json['uid'];
    typeLabel = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['search_highlight'] = searchHighlight;
    _data['followers_detail'] = followersDetail;
    _data['platform_sync_info'] = platformSyncInfo;
    _data['custom_verify'] = customVerify;
    _data['unique_id'] = uniqueId;
    _data['enterprise_verify_reason'] = enterpriseVerifyReason;
    _data['cover_url'] = coverUrl;
    _data['item_list'] = itemList;
    _data['homepage_bottom_toast'] = homepageBottomToast;
    _data['nickname'] = nickname;
    _data['avatar_thumb'] = avatarThumb.toJson();
    _data['mutual_relation_avatars'] = mutualRelationAvatars;
    _data['events'] = events;
    _data['cha_list'] = chaList;
    _data['need_points'] = needPoints;
    _data['can_set_geofencing'] = canSetGeofencing;
    _data['white_cover_url'] = whiteCoverUrl;
    _data['user_tags'] = userTags;
    _data['geofencing'] = geofencing;
    _data['relative_users'] = relativeUsers;
    _data['ad_cover_url'] = adCoverUrl;
    _data['sec_uid'] = secUid;
    _data['bold_fields'] = boldFields;
    _data['advance_feature_item_order'] = advanceFeatureItemOrder;
    _data['uid'] = uid;
    _data['type_label'] = typeLabel;
    return _data;
  }
}

class AvatarThumb {
  AvatarThumb({
    required this.uri,
    required this.urlList,
  });
  late final String uri;
  late final List<String> urlList;

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

class ReplyComment {
  ReplyComment({
    this.platformSyncInfo,
    this.geofencing,
    this.typeLabel,
    this.adCoverUrl,
    this.relativeUsers,
    required this.secUid,
    this.homepageBottomToast,
    required this.avatarThumb,
    required this.uniqueId,
    required this.enterpriseVerifyReason,
    this.coverUrl,
    this.events,
    this.advanceFeatureItemOrder,
    required this.nickname,
    this.followersDetail,
    this.itemList,
    this.canSetGeofencing,
    this.whiteCoverUrl,
    this.boldFields,
    this.mutualRelationAvatars,
    required this.uid,
    required this.customVerify,
    this.chaList,
    this.needPoints,
    this.userTags,
    this.searchHighlight,
  });
  late final Null platformSyncInfo;
  late final Null geofencing;
  late final Null typeLabel;
  late final Null adCoverUrl;
  late final Null relativeUsers;
  late final String secUid;
  late final Null homepageBottomToast;
  late final AvatarThumb avatarThumb;
  late final String uniqueId;
  late final String enterpriseVerifyReason;
  late final Null coverUrl;
  late final Null events;
  late final Null advanceFeatureItemOrder;
  late final String nickname;
  late final Null followersDetail;
  late final Null itemList;
  late final Null canSetGeofencing;
  late final Null whiteCoverUrl;
  late final Null boldFields;
  late final Null mutualRelationAvatars;
  late final String uid;
  late final String customVerify;
  late final Null chaList;
  late final Null needPoints;
  late final Null userTags;
  late final Null searchHighlight;

  ReplyComment.fromJson(Map<String, dynamic> json) {
    platformSyncInfo = null;
    geofencing = null;
    typeLabel = null;
    adCoverUrl = null;
    relativeUsers = null;
    secUid = json['sec_uid'];
    homepageBottomToast = null;
    avatarThumb = AvatarThumb.fromJson(json['avatar_thumb']);
    uniqueId = json['unique_id'];
    enterpriseVerifyReason = json['enterprise_verify_reason'];
    coverUrl = null;
    events = null;
    advanceFeatureItemOrder = null;
    nickname = json['nickname'];
    followersDetail = null;
    itemList = null;
    canSetGeofencing = null;
    whiteCoverUrl = null;
    boldFields = null;
    mutualRelationAvatars = null;
    uid = json['uid'];
    customVerify = json['custom_verify'];
    chaList = null;
    needPoints = null;
    userTags = null;
    searchHighlight = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['platform_sync_info'] = platformSyncInfo;
    _data['geofencing'] = geofencing;
    _data['type_label'] = typeLabel;
    _data['ad_cover_url'] = adCoverUrl;
    _data['relative_users'] = relativeUsers;
    _data['sec_uid'] = secUid;
    _data['homepage_bottom_toast'] = homepageBottomToast;
    _data['avatar_thumb'] = avatarThumb.toJson();
    _data['unique_id'] = uniqueId;
    _data['enterprise_verify_reason'] = enterpriseVerifyReason;
    _data['cover_url'] = coverUrl;
    _data['events'] = events;
    _data['advance_feature_item_order'] = advanceFeatureItemOrder;
    _data['nickname'] = nickname;
    _data['followers_detail'] = followersDetail;
    _data['item_list'] = itemList;
    _data['can_set_geofencing'] = canSetGeofencing;
    _data['white_cover_url'] = whiteCoverUrl;
    _data['bold_fields'] = boldFields;
    _data['mutual_relation_avatars'] = mutualRelationAvatars;
    _data['uid'] = uid;
    _data['custom_verify'] = customVerify;
    _data['cha_list'] = chaList;
    _data['need_points'] = needPoints;
    _data['user_tags'] = userTags;
    _data['search_highlight'] = searchHighlight;
    return _data;
  }
}

class CreateTime {
  CreateTime({
    this.canSetGeofencing,
    this.platformSyncInfo,
    this.geofencing,
    this.itemList,
    this.adCoverUrl,
    this.relativeUsers,
    required this.secUid,
    this.needPoints,
    this.whiteCoverUrl,
    this.mutualRelationAvatars,
    required this.uid,
    required this.avatarThumb,
    this.events,
    this.searchHighlight,
    required this.nickname,
    required this.customVerify,
    this.followersDetail,
    this.coverUrl,
    this.chaList,
    this.homepageBottomToast,
    this.boldFields,
    this.advanceFeatureItemOrder,
    required this.uniqueId,
    required this.enterpriseVerifyReason,
    this.typeLabel,
    this.userTags,
  });
  late final Null canSetGeofencing;
  late final Null platformSyncInfo;
  late final Null geofencing;
  late final Null itemList;
  late final Null adCoverUrl;
  late final Null relativeUsers;
  late final String secUid;
  late final Null needPoints;
  late final Null whiteCoverUrl;
  late final Null mutualRelationAvatars;
  late final String uid;
  late final AvatarThumb avatarThumb;
  late final Null events;
  late final Null searchHighlight;
  late final String nickname;
  late final String customVerify;
  late final Null followersDetail;
  late final Null coverUrl;
  late final Null chaList;
  late final Null homepageBottomToast;
  late final Null boldFields;
  late final Null advanceFeatureItemOrder;
  late final String uniqueId;
  late final String enterpriseVerifyReason;
  late final Null typeLabel;
  late final Null userTags;

  CreateTime.fromJson(Map<String, dynamic> json) {
    canSetGeofencing = null;
    platformSyncInfo = null;
    geofencing = null;
    itemList = null;
    adCoverUrl = null;
    relativeUsers = null;
    secUid = json['sec_uid'];
    needPoints = null;
    whiteCoverUrl = null;
    mutualRelationAvatars = null;
    uid = json['uid'];
    avatarThumb = AvatarThumb.fromJson(json['avatar_thumb']);
    events = null;
    searchHighlight = null;
    nickname = json['nickname'];
    customVerify = json['custom_verify'];
    followersDetail = null;
    coverUrl = null;
    chaList = null;
    homepageBottomToast = null;
    boldFields = null;
    advanceFeatureItemOrder = null;
    uniqueId = json['unique_id'];
    enterpriseVerifyReason = json['enterprise_verify_reason'];
    typeLabel = null;
    userTags = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['can_set_geofencing'] = canSetGeofencing;
    _data['platform_sync_info'] = platformSyncInfo;
    _data['geofencing'] = geofencing;
    _data['item_list'] = itemList;
    _data['ad_cover_url'] = adCoverUrl;
    _data['relative_users'] = relativeUsers;
    _data['sec_uid'] = secUid;
    _data['need_points'] = needPoints;
    _data['white_cover_url'] = whiteCoverUrl;
    _data['mutual_relation_avatars'] = mutualRelationAvatars;
    _data['uid'] = uid;
    _data['avatar_thumb'] = avatarThumb.toJson();
    _data['events'] = events;
    _data['search_highlight'] = searchHighlight;
    _data['nickname'] = nickname;
    _data['custom_verify'] = customVerify;
    _data['followers_detail'] = followersDetail;
    _data['cover_url'] = coverUrl;
    _data['cha_list'] = chaList;
    _data['homepage_bottom_toast'] = homepageBottomToast;
    _data['bold_fields'] = boldFields;
    _data['advance_feature_item_order'] = advanceFeatureItemOrder;
    _data['unique_id'] = uniqueId;
    _data['enterprise_verify_reason'] = enterpriseVerifyReason;
    _data['type_label'] = typeLabel;
    _data['user_tags'] = userTags;
    return _data;
  }
}
