import 'dart:collection';
import 'package:telsavideo/api/http_manager.dart';
import 'package:telsavideo/constants.dart';
import 'package:telsavideo/http/http_constant.dart';
import 'package:telsavideo/models/dto/recommend/itemlist_dto.dart';
import 'package:telsavideo/models/vo/recommend/itemlist_vo.dart';

class Api {
  /// the app interface
  static String api = apiPortail;
  static Future<ItemListVo> getRecommendItemList(ItemListDto? dto) async {
    Map<String, dynamic> map = new HashMap();
    map["cursor"] = dto?.cursor ?? 1;
    map["count"] = dto?.count ?? 10;
    var result = await HttpManager.getInstance()
        .get(
            url: HttpConstant.recommendItemList,
            cancelTokenTag: 'recomment',
            param: map)
        .then((value) => ItemListVo.fromJson(value));

    return result;
  }
}
