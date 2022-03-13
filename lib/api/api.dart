import 'dart:collection';
import 'package:telsavideo/api/http_manager.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/http/http_constant.dart';
import 'package:telsavideo/models/dto/recommend/itemlist_dto.dart';
import 'package:telsavideo/models/dto/signin/signin_dto.dart';
import 'package:telsavideo/models/vo/recommend/itemlist_vo.dart';
import 'package:telsavideo/models/vo/signin/signin_vo.dart';

class Api {
  /// the app interface
  static String api = apiPortail;

  ///signin the app
  static Future<SignInVo> getLoginResponse(SignInDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    params["username"] = dto?.username;
    params["password"] = dto?.password;
    var result = await HttpManager.getInstance()
        .post(url: HttpConstant.login, cancelTokenTag: 'signin', data: params);
    return SignInVo.fromJson(result);
  }

  /// get recommend item list
  static Future<ItemListVo> getRecommendItemList(ItemListDto? dto) async {
    Map<String, dynamic> params = new HashMap();
    params["cursor"] = dto?.cursor ?? 0;
    params["count"] = dto?.count ?? 20;
    var result = await HttpManager.getInstance().get(
        url: HttpConstant.recommendItemList,
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
        url: HttpConstant.followingItemList,
        cancelTokenTag: 'following',
        param: params);
    return ItemListVo.fromJson(result);
  }
}
