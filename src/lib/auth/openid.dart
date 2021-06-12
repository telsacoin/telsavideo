library steam_login.openid;

import 'dart:io';

import 'package:http/http.dart' as http;

import 'exceptions.dart';

class OpenId {
  final _steam_login = 'https://steamcommunity.com/openid/login';

  static const _openIdMode = 'checkid_setup';
  static const _openIdNs = 'http://specs.openid.net/auth/2.0';
  static const _openIdIdentifier =
      'http://specs.openid.net/auth/2.0/identifier_select';

  static final RegExp _validation_regexp =
      RegExp(r'^https://steamcommunity.com/openid/id/(7[0-9]{15,25})$');

  final String host;
  final String returnUrl;
  final Map<String, String> data;

  /// [OpenId] constructor, requires the current [HttpRequest],
  /// The [host] and [returnUrl] are taken from the [HttpRequest.requestedUri],
  /// [returnUrl] is usually the current URL.
  OpenId(HttpRequest request)
      : host = '${request.requestedUri.scheme}://${request.requestedUri.host}',
        returnUrl =
            '${request.requestedUri.scheme}://${request.requestedUri.host}${request.requestedUri.path}',
        data = request.uri.queryParameters;

  /// Manually instances an [OpenId]
  OpenId.raw(this.host, this.returnUrl, this.data);

  OpenId.fromUri(Uri uri)
      : host = '${uri.scheme}://${uri.host}',
        returnUrl = '${uri.scheme}://${uri.host}${uri.path}',
        data = uri.queryParameters;

  /// Return the authUrl
  Uri authUrl() {
    final data = {
      'openid.claimed_id': _openIdIdentifier,
      'openid.identity': _openIdIdentifier,
      'openid.mode': _openIdMode,
      'openid.ns': _openIdNs,
      'openid.realm': host,
      'openid.return_to': returnUrl
    };

    Uri uri = host.startsWith('https')
        ? Uri.https('steamcommunity.com', '/openid/login', data)
        : Uri.http('steamcommunity.com', '/openid/login', data);
    return uri;
  }

  /// Must be called only when mode is 'id_res' or an [OpenIdException] will be thrown.
  /// Validates the authentication and return a [Future] string with the user's steamid64.
  Future<String> validate() async {
    if (mode != 'id_res') {
      throw OpenIdException(
          OpenIdFailReason.param, 'must be equal to "id_res".', 'openid.mode');
    }

    if (data['openid.return_to'] != returnUrl) {
      throw OpenIdException(OpenIdFailReason.param,
          'must match the url of the current request.', 'openid.return_to');
    }

    Map<String, String> params = {
      'openid.assoc_handle': data['openid.assoc_handle'],
      'openid.signed': data['openid.signed'],
      'openid.sig': data['openid.sig'],
      'openid.ns': data['openid.ns']
    };

    if (params.containsValue(null) || data['openid.signed'] == null) {
      throw OpenIdException(OpenIdFailReason.params, 'Invalid OpenID params!');
    }

    List<String> split = data['openid.signed'].split(',');
    for (var part in split) {
      params['openid.$part'] = data['openid.$part'];
    }
    params['openid.mode'] = 'check_authentication';

    var resp = await http.post(Uri.parse(_steam_login), body: params);

    split = resp.body.split('\n');
    if (split[0] != 'ns:$_openIdNs')
      throw OpenIdException(
          OpenIdFailReason.invalid, 'Wrong ns in the response');

    if (split[1].endsWith('false')) {
      throw OpenIdException(
          OpenIdFailReason.invalid, 'Unable to validate openId');
    }

    var openIdUrl = data['openid.claimed_id'];
    if (!_validation_regexp.hasMatch(openIdUrl)) {
      throw OpenIdException(
          OpenIdFailReason.pattern, 'Invalid steam id pattern');
    }

    return _validation_regexp.firstMatch(openIdUrl).group(1);
  }

  /// Current [mode] (or an empty string if no mode is set).
  String get mode => data['openid.mode'] ?? '';
}
