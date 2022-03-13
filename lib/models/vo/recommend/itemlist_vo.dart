class ItemListVo {
  ItemListVo({
    this.statusCode,
    this.itemList,
    this.hasMore,
  });

  int? statusCode;
  List<ItemList>? itemList;
  bool? hasMore;

  factory ItemListVo.fromJson(Map<String, dynamic> json) => ItemListVo(
        statusCode: json["statusCode"] == null ? null : json["statusCode"],
        itemList: json["itemList"] == null
            ? null
            : List<ItemList>.from(json["itemList"]
                .map((x) => x == null ? null : ItemList.fromJson(x))),
        hasMore: json["hasMore"] == null ? null : json["hasMore"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "itemList": List<ItemList>.from(itemList!.map((x) => x.toJson())),
        "hasMore": hasMore,
      };
}

class ItemList {
  ItemList({
    this.id,
    this.desc,
    this.createTime,
    this.video,
    this.author,
    this.music,
    this.challenges,
    this.stats,
    this.duetInfo,
    this.originalItem,
    this.officalItem,
    this.textExtra,
    this.secret,
    this.forFriend,
    this.digged,
    this.itemCommentStatus,
    this.showNotPass,
    this.vl1,
    this.itemMute,
    this.authorStats,
    this.privateItem,
    this.duetEnabled,
    this.stitchEnabled,
    this.shareEnabled,
    this.stickersOnItem,
    this.isAd,
    this.duetDisplay,
    this.stitchDisplay,
  });

  String? id;
  String? desc;
  int? createTime;
  Video? video;
  Author? author;
  Music? music;
  List<Challenge>? challenges;
  Stats? stats;
  DuetInfo? duetInfo;
  bool? originalItem;
  bool? officalItem;
  List<TextExtra>? textExtra;
  bool? secret;
  bool? forFriend;
  bool? digged;
  int? itemCommentStatus;
  bool? showNotPass;
  bool? vl1;
  bool? itemMute;
  AuthorStats? authorStats;
  bool? privateItem;
  bool? duetEnabled;
  bool? stitchEnabled;
  bool? shareEnabled;
  List<StickersOnItem>? stickersOnItem;
  bool? isAd;
  int? duetDisplay;
  int? stitchDisplay;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        id: json["id"] == null ? null : json["id"],
        desc: json["desc"] == null ? null : json["desc"],
        createTime: json["createTime"] == null ? null : json["createTime"],
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
        music: json["music"] == null ? null : Music.fromJson(json["music"]),
        challenges: json["challenges"] == null
            ? null
            : List<Challenge>.from(json["challenges"]
                .map((x) => x == null ? null : Challenge.fromJson(x))),
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
        duetInfo: json["duetInfo"] == null
            ? null
            : DuetInfo.fromJson(json["duetInfo"]),
        originalItem:
            json["originalItem"] == null ? null : json["originalItem"],
        officalItem: json["officalItem"] == null ? null : json["officalItem"],
        textExtra: json["textExtra"] == null
            ? null
            : List<TextExtra>.from(json["textExtra"]
                .map((x) => x == null ? null : TextExtra.fromJson(x))),
        secret: json["secret"] == null ? null : json["secret"],
        forFriend: json["forFriend"] == null ? null : json["forFriend"],
        digged: json["digged"] == null ? null : json["digged"],
        itemCommentStatus: json["itemCommentStatus"] == null
            ? null
            : json["itemCommentStatus"],
        showNotPass: json["showNotPass"] == null ? null : json["showNotPass"],
        vl1: json["vl1"] == null ? null : json["vl1"],
        itemMute: json["itemMute"] == null ? null : json["itemMute"],
        authorStats: json["authorStats"] == null
            ? null
            : AuthorStats.fromJson(json["authorStats"]),
        privateItem: json["privateItem"] == null ? null : json["privateItem"],
        duetEnabled: json["duetEnabled"] == null ? null : json["duetEnabled"],
        stitchEnabled:
            json["stitchEnabled"] == null ? null : json["stitchEnabled"],
        shareEnabled:
            json["shareEnabled"] == null ? null : json["shareEnabled"],
        stickersOnItem: json["stickersOnItem"] == null
            ? null
            : List<StickersOnItem>.from(json["stickersOnItem"]
                .map((x) => x == null ? null : StickersOnItem.fromJson(x))),
        isAd: json["isAd"] == null ? null : json["isAd"],
        duetDisplay: json["duetDisplay"] == null ? null : json["duetDisplay"],
        stitchDisplay:
            json["stitchDisplay"] == null ? null : json["stitchDisplay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "desc": desc,
        "createTime": createTime,
        "video": video!.toJson(),
        "author": author!.toJson(),
        "music": music!.toJson(),
        "challenges": challenges == null
            ? null
            : List<dynamic>.from(challenges!.map((x) => x.toJson())),
        "stats": stats!.toJson(),
        "duetInfo": duetInfo!.toJson(),
        "originalItem": originalItem,
        "officalItem": officalItem,
        "textExtra": textExtra == null
            ? null
            : List<dynamic>.from(textExtra!.map((x) => x.toJson())),
        "secret": secret,
        "forFriend": forFriend,
        "digged": digged,
        "itemCommentStatus": itemCommentStatus,
        "showNotPass": showNotPass,
        "vl1": vl1,
        "itemMute": itemMute,
        "authorStats": authorStats!.toJson(),
        "privateItem": privateItem,
        "duetEnabled": duetEnabled,
        "stitchEnabled": stitchEnabled,
        "shareEnabled": shareEnabled,
        "stickersOnItem": stickersOnItem == null
            ? null
            : List<dynamic>.from(stickersOnItem!.map((x) => x.toJson())),
        "isAd": isAd,
        "duetDisplay": duetDisplay,
        "stitchDisplay": stitchDisplay,
      };
}

class Author {
  Author({
    this.id,
    this.uniqueId,
    this.nickname,
    this.avatarThumb,
    this.avatarMedium,
    this.avatarLarger,
    this.signature,
    this.verified,
    this.secUid,
    this.secret,
    this.ftc,
    this.relation,
    this.openFavorite,
    this.commentSetting,
    this.duetSetting,
    this.stitchSetting,
    this.privateAccount,
  });

  String? id;
  String? uniqueId;
  String? nickname;
  String? avatarThumb;
  String? avatarMedium;
  String? avatarLarger;
  String? signature;
  bool? verified;
  String? secUid;
  bool? secret;
  bool? ftc;
  int? relation;
  bool? openFavorite;
  int? commentSetting;
  int? duetSetting;
  int? stitchSetting;
  bool? privateAccount;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        uniqueId: json["uniqueId"],
        nickname: json["nickname"],
        avatarThumb: json["avatarThumb"],
        avatarMedium: json["avatarMedium"],
        avatarLarger: json["avatarLarger"],
        signature: json["signature"],
        verified: json["verified"],
        secUid: json["secUid"],
        secret: json["secret"],
        ftc: json["ftc"],
        relation: json["relation"],
        openFavorite: json["openFavorite"],
        commentSetting: json["commentSetting"],
        duetSetting: json["duetSetting"],
        stitchSetting: json["stitchSetting"],
        privateAccount: json["privateAccount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uniqueId": uniqueId,
        "nickname": nickname,
        "avatarThumb": avatarThumb,
        "avatarMedium": avatarMedium,
        "avatarLarger": avatarLarger,
        "signature": signature,
        "verified": verified,
        "secUid": secUid,
        "secret": secret,
        "ftc": ftc,
        "relation": relation,
        "openFavorite": openFavorite,
        "commentSetting": commentSetting,
        "duetSetting": duetSetting,
        "stitchSetting": stitchSetting,
        "privateAccount": privateAccount,
      };
}

class AuthorStats {
  AuthorStats({
    this.followingCount,
    this.followerCount,
    this.heartCount,
    this.videoCount,
    this.diggCount,
    this.heart,
  });

  int? followingCount;
  int? followerCount;
  int? heartCount;
  int? videoCount;
  int? diggCount;
  int? heart;

  factory AuthorStats.fromJson(Map<String, dynamic> json) => AuthorStats(
        followingCount: json["followingCount"],
        followerCount: json["followerCount"],
        heartCount: json["heartCount"],
        videoCount: json["videoCount"],
        diggCount: json["diggCount"],
        heart: json["heart"],
      );

  Map<String, dynamic> toJson() => {
        "followingCount": followingCount,
        "followerCount": followerCount,
        "heartCount": heartCount,
        "videoCount": videoCount,
        "diggCount": diggCount,
        "heart": heart,
      };
}

class Challenge {
  Challenge({
    this.id,
    this.title,
    this.desc,
    this.profileThumb,
    this.profileMedium,
    this.profileLarger,
    this.coverThumb,
    this.coverMedium,
    this.coverLarger,
    this.isCommerce,
  });

  String? id;
  String? title;
  String? desc;
  String? profileThumb;
  String? profileMedium;
  String? profileLarger;
  String? coverThumb;
  String? coverMedium;
  String? coverLarger;
  bool? isCommerce;

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        profileThumb: json["profileThumb"],
        profileMedium: json["profileMedium"],
        profileLarger: json["profileLarger"],
        coverThumb: json["coverThumb"],
        coverMedium: json["coverMedium"],
        coverLarger: json["coverLarger"],
        isCommerce: json["isCommerce"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "profileThumb": profileThumb,
        "profileMedium": profileMedium,
        "profileLarger": profileLarger,
        "coverThumb": coverThumb,
        "coverMedium": coverMedium,
        "coverLarger": coverLarger,
        "isCommerce": isCommerce,
      };
}

class DuetInfo {
  DuetInfo({
    this.duetFromId,
  });

  String? duetFromId;

  factory DuetInfo.fromJson(Map<String, dynamic> json) => DuetInfo(
        duetFromId: json["duetFromId"],
      );

  Map<String, dynamic> toJson() => {
        "duetFromId": duetFromId,
      };
}

class Music {
  Music({
    this.id,
    this.title,
    this.playUrl,
    this.coverThumb,
    this.coverMedium,
    this.coverLarge,
    this.authorName,
    this.original,
    this.duration,
    this.album,
  });

  String? id;
  String? title;
  String? playUrl;
  String? coverThumb;
  String? coverMedium;
  String? coverLarge;
  String? authorName;
  bool? original;
  int? duration;
  String? album;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        title: json["title"],
        playUrl: json["playUrl"],
        coverThumb: json["coverThumb"],
        coverMedium: json["coverMedium"],
        coverLarge: json["coverLarge"],
        authorName: json["authorName"],
        original: json["original"],
        duration: json["duration"],
        album: json["album"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "playUrl": playUrl,
        "coverThumb": coverThumb,
        "coverMedium": coverMedium,
        "coverLarge": coverLarge,
        "authorName": authorName,
        "original": original,
        "duration": duration,
        "album": album,
      };
}

class Stats {
  Stats({
    this.diggCount,
    this.shareCount,
    this.commentCount,
    this.playCount,
  });

  int? diggCount;
  int? shareCount;
  int? commentCount;
  int? playCount;

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        diggCount: json["diggCount"],
        shareCount: json["shareCount"],
        commentCount: json["commentCount"],
        playCount: json["playCount"],
      );

  Map<String, dynamic> toJson() => {
        "diggCount": diggCount,
        "shareCount": shareCount,
        "commentCount": commentCount,
        "playCount": playCount,
      };
}

class StickersOnItem {
  StickersOnItem({
    this.stickerType,
    this.stickerText,
  });

  int? stickerType;
  List<String>? stickerText;

  factory StickersOnItem.fromJson(Map<String, dynamic> json) => StickersOnItem(
        stickerType: json["stickerType"],
        stickerText: json["stickerText"] ??
            List<String>.from(json["stickerText"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "stickerType": stickerType,
        "stickerText": List<dynamic>.from(stickerText!.map((x) => x)),
      };
}

class TextExtra {
  TextExtra({
    this.awemeId,
    this.start,
    this.end,
    this.hashtagName,
    this.hashtagId,
    this.type,
    this.userId,
    this.isCommerce,
    this.userUniqueId,
    this.secUid,
  });

  String? awemeId;
  int? start;
  int? end;
  String? hashtagName;
  int? hashtagId;
  int? type;
  String? userId;
  bool? isCommerce;
  String? userUniqueId;
  String? secUid;

  factory TextExtra.fromJson(Map<String, dynamic> json) => TextExtra(
        awemeId: json["awemeId"],
        start: json["start"],
        end: json["end"],
        hashtagName: json["hashtagName"],
        hashtagId: json["hashtagId"],
        type: json["type"],
        userId: json["userId"],
        isCommerce: json["isCommerce"],
        userUniqueId: json["userUniqueId"],
        secUid: json["secUid"],
      );

  Map<String, dynamic> toJson() => {
        "awemeId": awemeId,
        "start": start,
        "end": end,
        "hashtagName": hashtagName,
        "hashtagId": hashtagId,
        "type": type,
        "userId": userId,
        "isCommerce": isCommerce,
        "userUniqueId": userUniqueId,
        "secUid": secUid,
      };
}

class Video {
  Video({
    this.id,
    this.height,
    this.width,
    this.duration,
    this.ratio,
    this.cover,
    this.originCover,
    this.dynamicCover,
    this.playAddr,
    this.downloadAddr,
    this.shareCover,
    this.reflowCover,
    this.bitrate,
    this.encodedType,
    this.format,
    this.videoQuality,
    this.encodeUserTag,
    this.codecType,
    this.definition,
  });

  String? id;
  int? height;
  int? width;
  int? duration;
  String? ratio;
  String? cover;
  String? originCover;
  String? dynamicCover;
  String? playAddr;
  String? downloadAddr;
  //List<String>? shareCover;
  String? shareCover;
  String? reflowCover;
  int? bitrate;
  String? encodedType;
  String? format;
  String? videoQuality;
  String? encodeUserTag;
  String? codecType;
  String? definition;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        height: json["height"],
        width: json["width"],
        duration: json["duration"],
        ratio: json["ratio"],
        cover: json["cover"],
        originCover: json["originCover"],
        dynamicCover: json["dynamicCover"],
        playAddr: json["playAddr"],
        downloadAddr: json["downloadAddr"],
        //shareCover: json["shareCover"] ??
        //   List<String>.from(json["shareCover"].map((x) => x)),
        shareCover: json["shareCover"],
        reflowCover: json["reflowCover"],
        bitrate: json["bitrate"],
        encodedType: json["encodedType"],
        format: json["format"],
        videoQuality: json["videoQuality"],
        encodeUserTag: json["encodeUserTag"],
        codecType: json["codecType"],
        definition: json["definition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "height": height,
        "width": width,
        "duration": duration,
        "ratio": ratio,
        "cover": cover,
        "originCover": originCover,
        "dynamicCover": dynamicCover,
        "playAddr": playAddr,
        "downloadAddr": downloadAddr,
        "shareCover":
            shareCover, //List<dynamic>.from(shareCover!.map((x) => x)),
        "reflowCover": reflowCover,
        "bitrate": bitrate,
        "encodedType": encodedType,
        "format": format,
        "videoQuality": videoQuality,
        "encodeUserTag": encodeUserTag,
        "codecType": codecType,
        "definition": definition,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
