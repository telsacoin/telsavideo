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

      options.headers.putIfAbsent(
          'user-agent',
          () =>
              'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1');

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
