import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/api/http_method.dart';
import 'package:telsavideo/common/utils.dart';
import 'package:telsavideo/http/base/http_error.dart';
import 'package:telsavideo/http/http_constant.dart';
import 'package:telsavideo/http/interceptors/header_interceptor.dart';
import 'package:telsavideo/http/interceptors/log_interceptor.dart';
import 'package:telsavideo/http/response/result.dart';
import 'package:telsavideo/http/util.dart';

class HttpManager {
  static const int CONNECT_TIMEOUT = 30 * 1000;
  static const int RECEIVE_TIMEOUT = 30 * 1000;

  Map<String, CancelToken> _cancelTokens = new Map();

  Dio? _dio, _dioUpload;

  /// singletion instance
  static HttpManager? _instance;

  HttpManager._internal() {
    if (null == _dio) {
      BaseOptions options = BaseOptions(
        baseUrl: HttpConstant.baseUrl,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );
      _dio = Dio(options);

      _dio!.interceptors.add(HeaderInterceptor());
      _dio!.interceptors.add(LogInterceptors(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true));
    }

    if (null == _dioUpload) {
      BaseOptions options = BaseOptions(
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
      );

      _dioUpload = Dio(options);

      _dioUpload!.interceptors.add(LogInterceptors(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true));
    }
  }

  factory HttpManager.getInstance() => _getInstance();

  static _getInstance() {
    if (null == _instance) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  String _restfulUrl(String url, Map<String, dynamic> params) {
    params.forEach((key, value) {
      if (url.indexOf(key) != -1) {
        url = url.replaceAll(':$key', value.toString());
      }
    });
    return Api.api + url;
  }

  void cancel(String cancelTokenTag) {
    if (_cancelTokens.containsKey(cancelTokenTag)) {
      if (!_cancelTokens[cancelTokenTag]!.isCancelled) {
        _cancelTokens[cancelTokenTag]!.cancel();
      }
      _cancelTokens.remove(cancelTokenTag);
    }
  }

  /// the request function http
  Future _requestHttp(
      {required String url,
      String? method,
      String? cancelTokenTag,
      Map<String, dynamic>? params,
      data,
      Options? options}) async {
    //EasyLoading.show();
    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectionState.none) {
      throw HttpError(HttpError.NETWORK_ERROR, "网络异常，请检查网络");
    }

    //设置默认值
    url = _restfulUrl(url, params!);
    if (params.isNullOrEmpty) {
      params = {};
    }
    if (method.isNullOrEmpty) {
      method = HttpMethod.GET;
    }

    if (options != null) {
      options.method = method;
    }
    if (options.isNullOrEmpty) {
      options = Options(
        method: method,
      );
    }

    CancelToken? cancelToken;
    if (cancelTokenTag != null) {
      cancelToken = (_cancelTokens[cancelTokenTag] == null
          ? CancelToken()
          : _cancelTokens[cancelTokenTag])!;
      _cancelTokens[cancelTokenTag] = cancelToken;
    }
    try {
      Response<Map<String, dynamic>>? response = await _dio?.request(url,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
      //EasyLoading.dismiss();
      if (response?.data!['code'] == 0) {
        Util.set('isLogin', true);
        return Result.fromJson(response?.data).data;
      } else if (response?.data!['statusCode'] == 0) {
        Util.set('isLogin', true);
        return response?.data;
      } else if (response?.data!['status'] == 401) {
        Util.set('isLogin', false);
        return response?.data;
        //throw HttpError(HttpError.FORBIDDEN.toString(), "请登录");
      } else {
        //EasyLoading.showToast(response?.data!['message']!);
        return response?.data;
      }
    } catch (e, s) {
      //EasyLoading.dismiss();
      print(e);
    }
  }

  /// upload common function
  Future<bool> uploadFile(
      {required String url,
      String? method,
      required String cancelTokenTag,
      Map<String, dynamic>? params,
      data,
      Options? options}) async {
    //请求中loading
    //EasyLoading.show();
    //检查网络是否连接
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      throw (HttpError(HttpError.NETWORK_ERROR, "网络异常，请检查网络"));
    }

    //设置默认值
    url = _restfulUrl(url, params!);
    if (params.isNullOrEmpty) {
      params = {};
    }
    if (method.isNullOrEmpty) {
      method = HttpMethod.GET;
    }

    if (options != null) {
      options.method = method;
    }
    if (options.isNullOrEmpty) {
      options = Options(
        method: method,
      );
    }

    CancelToken? cancelToken;
    if (cancelTokenTag != null) {
      cancelToken = (_cancelTokens[cancelTokenTag] == null
          ? CancelToken()
          : _cancelTokens[cancelTokenTag])!;
      _cancelTokens[cancelTokenTag] = cancelToken;
    }

    try {
      Response? response = await _dioUpload?.request(url,
          queryParameters: params,
          data: data,
          options: options,
          cancelToken: cancelToken);
      //EasyLoading.dismiss();
      if (response?.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      //EasyLoading.dismiss();
      print(e);
      return false;
    }
  }

  /// get request
  Future get(
      {required String url,
      required String cancelTokenTag,
      Map<String, dynamic>? param,
      Options? options}) async {
    return await _requestHttp(
      url: url,
      method: HttpMethod.GET,
      cancelTokenTag: cancelTokenTag,
      params: param,
      options: options,
    );
  }

  /// post request
  Future post(
      {required String url,
      required String cancelTokenTag,
      Map<String, dynamic>? params,
      data,
      Options? options}) async {
    return await _requestHttp(
      url: url,
      method: HttpMethod.POST,
      cancelTokenTag: cancelTokenTag,
      params: params,
      data: data,
      options: options,
    );
  }

  /// the put request
  Future put(
      {required String url,
      required String cancelTokenTag,
      Map<String, dynamic>? params,
      data,
      Options? options,
      int? typeHttp}) async {
    return await _requestHttp(
      url: url,
      method: HttpMethod.PUT,
      cancelTokenTag: cancelTokenTag,
      params: params,
      data: data,
      options: options,
    );
  }
}
