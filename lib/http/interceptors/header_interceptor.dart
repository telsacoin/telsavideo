import 'package:dio/dio.dart';
import 'package:telsavideo/http/base/base_domain.dart';
import 'package:telsavideo/http/util.dart';

class HeaderInterceptor implements Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    handler.next(err);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      String token = '';
      await Util.getString(BaseDomain.xUSERTOKEN).then((text) {
        token = text != null ? text : "";
      });

      if (token.length > 0) {
        options.headers[BaseDomain.xUSERTOKEN] = token;
      }
    } catch (e) {
      print(e);
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }
}
