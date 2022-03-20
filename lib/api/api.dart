import 'dart:collection';
import 'dart:core';
import 'package:telsavideo/api/http_manager.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/http/http_constant.dart';
import 'package:telsavideo/models/dto/comment/comment_item_digg_dto.dart';
import 'package:telsavideo/models/dto/comment/comment_item_list_dto.dart';
import 'package:telsavideo/models/dto/comment/comment_list_reply_dto.dart';
import 'package:telsavideo/models/dto/message/notification_dto.dart';
import 'package:telsavideo/models/dto/discover/discover_challenge_dto.dart';
import 'package:telsavideo/models/dto/discover/discover_music_dto.dart';
import 'package:telsavideo/models/dto/discover/discover_user_dto.dart';
import 'package:telsavideo/models/dto/message/notification_make_read_dto.dart';
import 'package:telsavideo/models/dto/recommend/itemlist_dto.dart';
import 'package:telsavideo/models/dto/signin/signin_dto.dart';
import 'package:telsavideo/models/dto/signup/signup_dto.dart';
import 'package:telsavideo/models/vo/comment/comment_item_digg_vo.dart';
import 'package:telsavideo/models/vo/comment/comment_item_list_vo.dart';
import 'package:telsavideo/models/vo/comment/comment_list_reply_vo.dart';
import 'package:telsavideo/models/vo/discover/discover_challenage_vo.dart';
import 'package:telsavideo/models/vo/discover/discover_music_vo.dart';
import 'package:telsavideo/models/vo/discover/discover_user_vo.dart';
import 'package:telsavideo/models/vo/message/notification_make_read_vo.dart';
import 'package:telsavideo/models/vo/message/notification_vo.dart';
import 'package:telsavideo/models/vo/recommend/itemlist_vo.dart';
import 'package:telsavideo/models/vo/signin/signin_vo.dart';
import 'package:telsavideo/models/vo/signup/signup.dart';

class Api {
  /// the app interface
  static String api = apiPortail;

  ///signin the app
  static Future<SignInVo> postLoginResponse(SignInDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    params["username"] = dto?.username;
    params["password"] = dto?.password;
    var result = await HttpManager.getInstance().post(
        url: Api.api + HttpConstant.login,
        cancelTokenTag: 'signin',
        data: params);
    return SignInVo.fromJson(result);
  }

  /// signup the request
  static Future<SignUpVO> postSignUpResponse(SignUpDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().post(
        url: Api.api + HttpConstant.register,
        cancelTokenTag: 'signup',
        data: params);

    return SignUpVO.fromJson(result);
  }

  /// get recommend item list
  static Future<ItemListVo> getRecommendItemList(ItemListDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    params["cursor"] = dto?.cursor ?? 0;
    params["count"] = dto?.count ?? 20;
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.recommendItemList,
        cancelTokenTag: 'recomment',
        param: params);

    return ItemListVo.fromJson(result);
  }

  /// the following item list videos
  static Future<ItemListVo> getFollowingItemList(ItemListDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    params["cursor"] = dto?.cursor ?? 0;
    params["count"] = dto?.count ?? 20;
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.followingItemList,
        cancelTokenTag: 'following',
        param: params);
    return ItemListVo.fromJson(result);
  }

  ///digg the video item
  static Future<CommentItemDiggVo> postCommnetItemDigg(
      CommentItemDiggDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().post(
        url: Api.api + HttpConstant.commentItemDigg,
        cancelTokenTag: 'digg',
        data: params);

    return CommentItemDiggVo.fromJson(result);
  }

  /// get the comment list
  static Future<CommentItemListVo> getCommentItemList(
      CommentItemListDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().post(
        url: Api.api + HttpConstant.commentList,
        cancelTokenTag: 'commentlist',
        data: params);

    return CommentItemListVo.fromJson(result);
  }

  /// get commentlist reply
  static Future<CommentListReplyVo> getCommentListReply(
      CommentListReplyDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.commentListReply,
        cancelTokenTag: 'commentlistreply',
        param: params);

    return CommentListReplyVo.fromJson(result);
  }

  /// get discover music
  static Future<DiscoverMusicVo> getDiscoverMusic(DiscoverMusicDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.discoverMusic,
        cancelTokenTag: 'discovermusic',
        param: params);

    return DiscoverMusicVo.fromJson(result);
  }

  /// get discover challenge
  static Future<DiscoverChallengeVo> getDiscoverChanllenge(
      DiscoverChallengeDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.discoverChallenge,
        cancelTokenTag: 'discoverchallenge',
        param: params);

    return DiscoverChallengeVo.fromJson(result);
  }

  /// get discover users
  static Future<DiscoverUserVo> getDiscoverUser(DiscoverUserDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.discoverUser,
        cancelTokenTag: 'discoveruser',
        param: params);

    return DiscoverUserVo.fromJson(result);
  }

  /// upload videos module

  /// get notifications
  static Future<NotificationVo> getNotifications(NotificationDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().get(
        url: Api.api + HttpConstant.userNoticeList,
        cancelTokenTag: 'notification',
        param: params);
    return NotificationVo.fromJson(result);
  }

  /// make notification as read status
  static Future<NotificationMakeReadVo> postNotificationMakeRead(
      NotificationMakeReadDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    var result = await HttpManager.getInstance().post(
        url: Api.api + HttpConstant.userNoticeMakeRead,
        cancelTokenTag: 'notificationmakeread',
        data: params);
    return NotificationMakeReadVo.fromJson(result);
  }
}
