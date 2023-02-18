class CommentItemListVo {
  final int? statusCode;
  final List<Comments>? comments;
  final int? cursor;
  final int? hasMore;
  final int? replyStyle;
  final int? total;
  final Extra? extra;
  final LogPb? logPb;
  final List<dynamic>? topGifts;
  final bool? aliasCommentDeleted;

  CommentItemListVo({
    this.statusCode,
    this.comments,
    this.cursor,
    this.hasMore,
    this.replyStyle,
    this.total,
    this.extra,
    this.logPb,
    this.topGifts,
    this.aliasCommentDeleted,
  });

  CommentItemListVo.fromJson(Map<String, dynamic> json)
      : statusCode = json['status_code'] as int?,
        comments = (json['comments'] as List?)
            ?.map((dynamic e) => Comments.fromJson(e as Map<String, dynamic>))
            .toList(),
        cursor = json['cursor'] as int?,
        hasMore = json['has_more'] as int?,
        replyStyle = json['reply_style'] as int?,
        total = json['total'] as int?,
        extra = (json['extra'] as Map<String, dynamic>?) != null
            ? Extra.fromJson(json['extra'] as Map<String, dynamic>)
            : null,
        logPb = (json['log_pb'] as Map<String, dynamic>?) != null
            ? LogPb.fromJson(json['log_pb'] as Map<String, dynamic>)
            : null,
        topGifts = json['top_gifts'] as List?,
        aliasCommentDeleted = json['alias_comment_deleted'] as bool?;

  Map<String, dynamic> toJson() => {
        'status_code': statusCode,
        'comments': comments?.map((e) => e.toJson()).toList(),
        'cursor': cursor,
        'has_more': hasMore,
        'reply_style': replyStyle,
        'total': total,
        'extra': extra?.toJson(),
        'log_pb': logPb?.toJson(),
        'top_gifts': topGifts,
        'alias_comment_deleted': aliasCommentDeleted
      };
}

class Comments {
  final String? cid;
  final String? text;
  final String? awemeId;
  final int? createTime;
  final int? diggCount;
  final int? status;
  final User? user;
  final String? replyId;
  final int? userDigged;
  final List<ReplyComment>? replyComment;
  final List<TextExtra>? textExtra;
  final int? replyCommentTotal;
  final String? replyToReplyId;
  final bool? isAuthorDigged;
  final int? stickPosition;
  final bool? userBuried;
  final dynamic labelList;
  final bool? authorPin;
  final bool? noShow;
  final int? collectStat;
  final int? transBtnStyle;

  Comments({
    this.cid,
    this.text,
    this.awemeId,
    this.createTime,
    this.diggCount,
    this.status,
    this.user,
    this.replyId,
    this.userDigged,
    this.replyComment,
    this.textExtra,
    this.replyCommentTotal,
    this.replyToReplyId,
    this.isAuthorDigged,
    this.stickPosition,
    this.userBuried,
    this.labelList,
    this.authorPin,
    this.noShow,
    this.collectStat,
    this.transBtnStyle,
  });

  Comments.fromJson(Map<String, dynamic> json)
      : cid = json['cid'] as String?,
        text = json['text'] as String?,
        awemeId = json['aweme_id'] as String?,
        createTime = json['create_time'] as int?,
        diggCount = json['digg_count'] as int?,
        status = json['status'] as int?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        replyId = json['reply_id'] as String?,
        userDigged = json['user_digged'] as int?,
        replyComment = (json['reply_comment'] as List?)
            ?.map(
                (dynamic e) => ReplyComment.fromJson(e as Map<String, dynamic>))
            .toList(),
        textExtra = (json['text_extra'] as List?)
            ?.map((dynamic e) => TextExtra.fromJson(e as Map<String, dynamic>))
            .toList(),
        replyCommentTotal = json['reply_comment_total'] as int?,
        replyToReplyId = json['reply_to_reply_id'] as String?,
        isAuthorDigged = json['is_author_digged'] as bool?,
        stickPosition = json['stick_position'] as int?,
        userBuried = json['user_buried'] as bool?,
        labelList = json['label_list'],
        authorPin = json['author_pin'] as bool?,
        noShow = json['no_show'] as bool?,
        collectStat = json['collect_stat'] as int?,
        transBtnStyle = json['trans_btn_style'] as int?;

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'text': text,
        'aweme_id': awemeId,
        'create_time': createTime,
        'digg_count': diggCount,
        'status': status,
        'user': user?.toJson(),
        'reply_id': replyId,
        'user_digged': userDigged,
        'reply_comment': replyComment?.map((e) => e.toJson()).toList(),
        'text_extra': textExtra?.map((e) => e.toJson()).toList(),
        'reply_comment_total': replyCommentTotal,
        'reply_to_reply_id': replyToReplyId,
        'is_author_digged': isAuthorDigged,
        'stick_position': stickPosition,
        'user_buried': userBuried,
        'label_list': labelList,
        'author_pin': authorPin,
        'no_show': noShow,
        'collect_stat': collectStat,
        'trans_btn_style': transBtnStyle
      };
}

class User {
  final String? uid;
  final String? nickname;
  final AvatarThumb? avatarThumb;
  final String? customVerify;
  final String? uniqueId;
  final String? enterpriseVerifyReason;
  final dynamic followersDetail;
  final dynamic platformSyncInfo;
  final dynamic geofencing;
  final dynamic coverUrl;
  final dynamic itemList;
  final dynamic typeLabel;
  final dynamic adCoverUrl;
  final dynamic relativeUsers;
  final dynamic chaList;
  final String? secUid;
  final dynamic needPoints;
  final dynamic homepageBottomToast;
  final dynamic canSetGeofencing;
  final dynamic whiteCoverUrl;
  final dynamic userTags;
  final dynamic boldFields;
  final dynamic searchHighlight;
  final dynamic mutualRelationAvatars;
  final dynamic events;
  final dynamic advanceFeatureItemOrder;

  User({
    this.uid,
    this.nickname,
    this.avatarThumb,
    this.customVerify,
    this.uniqueId,
    this.enterpriseVerifyReason,
    this.followersDetail,
    this.platformSyncInfo,
    this.geofencing,
    this.coverUrl,
    this.itemList,
    this.typeLabel,
    this.adCoverUrl,
    this.relativeUsers,
    this.chaList,
    this.secUid,
    this.needPoints,
    this.homepageBottomToast,
    this.canSetGeofencing,
    this.whiteCoverUrl,
    this.userTags,
    this.boldFields,
    this.searchHighlight,
    this.mutualRelationAvatars,
    this.events,
    this.advanceFeatureItemOrder,
  });

  User.fromJson(Map<String, dynamic> json)
      : uid = json['uid'] as String?,
        nickname = json['nickname'] as String?,
        avatarThumb = (json['avatar_thumb'] as Map<String, dynamic>?) != null
            ? AvatarThumb.fromJson(json['avatar_thumb'] as Map<String, dynamic>)
            : null,
        customVerify = json['custom_verify'] as String?,
        uniqueId = json['unique_id'] as String?,
        enterpriseVerifyReason = json['enterprise_verify_reason'] as String?,
        followersDetail = json['followers_detail'],
        platformSyncInfo = json['platform_sync_info'],
        geofencing = json['geofencing'],
        coverUrl = json['cover_url'],
        itemList = json['item_list'],
        typeLabel = json['type_label'],
        adCoverUrl = json['ad_cover_url'],
        relativeUsers = json['relative_users'],
        chaList = json['cha_list'],
        secUid = json['sec_uid'] as String?,
        needPoints = json['need_points'],
        homepageBottomToast = json['homepage_bottom_toast'],
        canSetGeofencing = json['can_set_geofencing'],
        whiteCoverUrl = json['white_cover_url'],
        userTags = json['user_tags'],
        boldFields = json['bold_fields'],
        searchHighlight = json['search_highlight'],
        mutualRelationAvatars = json['mutual_relation_avatars'],
        events = json['events'],
        advanceFeatureItemOrder = json['advance_feature_item_order'];

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'nickname': nickname,
        'avatar_thumb': avatarThumb?.toJson(),
        'custom_verify': customVerify,
        'unique_id': uniqueId,
        'enterprise_verify_reason': enterpriseVerifyReason,
        'followers_detail': followersDetail,
        'platform_sync_info': platformSyncInfo,
        'geofencing': geofencing,
        'cover_url': coverUrl,
        'item_list': itemList,
        'type_label': typeLabel,
        'ad_cover_url': adCoverUrl,
        'relative_users': relativeUsers,
        'cha_list': chaList,
        'sec_uid': secUid,
        'need_points': needPoints,
        'homepage_bottom_toast': homepageBottomToast,
        'can_set_geofencing': canSetGeofencing,
        'white_cover_url': whiteCoverUrl,
        'user_tags': userTags,
        'bold_fields': boldFields,
        'search_highlight': searchHighlight,
        'mutual_relation_avatars': mutualRelationAvatars,
        'events': events,
        'advance_feature_item_order': advanceFeatureItemOrder
      };
}

class AvatarThumb {
  final String? uri;
  final List<String>? urlList;

  AvatarThumb({
    this.uri,
    this.urlList,
  });

  AvatarThumb.fromJson(Map<String, dynamic> json)
      : uri = json['uri'] as String?,
        urlList = (json['url_list'] as List?)
            ?.map((dynamic e) => e as String)
            .toList();

  Map<String, dynamic> toJson() => {'uri': uri, 'url_list': urlList};
}

class ReplyComment {
  final String? cid;
  final String? text;
  final String? awemeId;
  final int? createTime;
  final int? diggCount;
  final int? status;
  final User? user;
  final String? replyId;
  final int? userDigged;
  final dynamic replyComment;
  final List<dynamic>? textExtra;
  final String? labelText;
  final int? labelType;
  final String? replyToReplyId;
  final bool? isAuthorDigged;
  final bool? userBuried;
  final dynamic labelList;
  final bool? noShow;
  final int? collectStat;
  final int? transBtnStyle;

  ReplyComment({
    this.cid,
    this.text,
    this.awemeId,
    this.createTime,
    this.diggCount,
    this.status,
    this.user,
    this.replyId,
    this.userDigged,
    this.replyComment,
    this.textExtra,
    this.labelText,
    this.labelType,
    this.replyToReplyId,
    this.isAuthorDigged,
    this.userBuried,
    this.labelList,
    this.noShow,
    this.collectStat,
    this.transBtnStyle,
  });

  ReplyComment.fromJson(Map<String, dynamic> json)
      : cid = json['cid'] as String?,
        text = json['text'] as String?,
        awemeId = json['aweme_id'] as String?,
        createTime = json['create_time'] as int?,
        diggCount = json['digg_count'] as int?,
        status = json['status'] as int?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        replyId = json['reply_id'] as String?,
        userDigged = json['user_digged'] as int?,
        replyComment = json['reply_comment'],
        textExtra = json['text_extra'] as List?,
        labelText = json['label_text'] as String?,
        labelType = json['label_type'] as int?,
        replyToReplyId = json['reply_to_reply_id'] as String?,
        isAuthorDigged = json['is_author_digged'] as bool?,
        userBuried = json['user_buried'] as bool?,
        labelList = json['label_list'],
        noShow = json['no_show'] as bool?,
        collectStat = json['collect_stat'] as int?,
        transBtnStyle = json['trans_btn_style'] as int?;

  Map<String, dynamic> toJson() => {
        'cid': cid,
        'text': text,
        'aweme_id': awemeId,
        'create_time': createTime,
        'digg_count': diggCount,
        'status': status,
        'user': user?.toJson(),
        'reply_id': replyId,
        'user_digged': userDigged,
        'reply_comment': replyComment,
        'text_extra': textExtra,
        'label_text': labelText,
        'label_type': labelType,
        'reply_to_reply_id': replyToReplyId,
        'is_author_digged': isAuthorDigged,
        'user_buried': userBuried,
        'label_list': labelList,
        'no_show': noShow,
        'collect_stat': collectStat,
        'trans_btn_style': transBtnStyle
      };
}

class TextExtra {
  final int? start;
  final int? end;
  final String? userId;
  final String? hashtagName;
  final String? hashtagId;
  final String? secUid;

  TextExtra({
    this.start,
    this.end,
    this.userId,
    this.hashtagName,
    this.hashtagId,
    this.secUid,
  });

  TextExtra.fromJson(Map<String, dynamic> json)
      : start = json['start'] as int?,
        end = json['end'] as int?,
        userId = json['user_id'] as String?,
        hashtagName = json['hashtag_name'] as String?,
        hashtagId = json['hashtag_id'] as String?,
        secUid = json['sec_uid'] as String?;

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
        'user_id': userId,
        'hashtag_name': hashtagName,
        'hashtag_id': hashtagId,
        'sec_uid': secUid
      };
}

class Extra {
  final int? now;
  final dynamic fatalItemIds;

  Extra({
    this.now,
    this.fatalItemIds,
  });

  Extra.fromJson(Map<String, dynamic> json)
      : now = json['now'] as int?,
        fatalItemIds = json['fatal_item_ids'];

  Map<String, dynamic> toJson() => {'now': now, 'fatal_item_ids': fatalItemIds};
}

class LogPb {
  final String? imprId;

  LogPb({
    this.imprId,
  });

  LogPb.fromJson(Map<String, dynamic> json)
      : imprId = json['impr_id'] as String?;

  Map<String, dynamic> toJson() => {'impr_id': imprId};
}
