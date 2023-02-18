import 'dart:async';
import 'dart:convert';

import 'package:http/src/base_client.dart' as http;
import 'package:http/src/request.dart' as http;
import 'package:http/src/response.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;

import 'package:telsavideo/api/api.dart';
import 'package:telsavideo/api/steem.dart';
import 'package:telsavideo/services/endpoints.dart';
import 'package:telsavideo/api/impl/steem.dart';
import 'package:telsavideo/models/impl_models.dart';
import 'package:telsavideo/models/user.dart';
import 'package:telsavideo/services/requestor.dart';
import 'package:telsavideo/services/scopes.dart';

/// Manages authentication against the SteemConnect API
class SteemApiAuth {
  final String? clientId, clientSecret;
  final Uri? redirectUri;
  final List<SteemApiScope>? scopes = [];

  SteemApiAuth(this.clientId, this.clientSecret,
      {this.redirectUri, Iterable<SteemApiScope> scopes: const []}) {
    this.scopes!.addAll(scopes);
  }

  /// Creates or returns an OAuth2 grant that will be used to authenticate against the API.
  oauth2.AuthorizationCodeGrant get grant =>
      new oauth2.AuthorizationCodeGrant(clientId!, authEndpoint, tokenEndpoint,
          secret: clientSecret);

  /// Returns a URI that users can be redirected to to authenticate via applications with no server-side component.
  Uri getImplicitRedirectUri() {
    if (redirectUri == null)
      throw new StateError(
          'You have not provided a `redirectUri` to this SteemApiAuth instance.');
    return authEndpoint.replace(queryParameters: {
      'client_id': clientId,
      'redirect_uri': redirectUri.toString(),
      'response_type': 'token'
    });
  }

  /// Creates an API client from an access token
  ///
  /// You can optionally pass a [User], if you already have a reference to one.
  static SteemApi authorizeViaAccessToken(
      String accessToken, http.BaseClient httpClient,
      {User? user}) {
    return new SteemApiImpl(
        accessToken, user!, new _RequestorImpl(accessToken, httpClient));
  }
}

class _RequestorImpl extends Requestor {
  final String accessToken;
  final http.BaseClient client;

  _RequestorImpl(this.accessToken, this.client);

  @override
  Future<SteemResponse> send(http.Request request) {
    return client
        .send(request)
        .then<http.Response>(http.Response.fromStream)
        .then((response) {
      if (response.headers['content-type']?.contains('application/json') !=
          true)
        throw new FormatException(
            'The response is not formatted as JSON: "${response.body}"');
      Map<String, dynamic> untyped = jsonDecode(response.body);

      if (untyped is! Map)
        throw new FormatException('Expected the response to be a JSON object.');

      var r = new SteemResponse.fromJson(untyped);

      return r;
    });
  }

  @override
  Uri buildUri(String apiSource, String path,
      {Map<String, String>? queryParameters, String? method}) {
    var _root;
    Map<String, String> q =
        method == 'POST' ? {} : {'Authorization': accessToken}
          ..addAll(queryParameters!);
    if (apiSource == 'sc')
      _root = scRoot;
    else if (apiSource == 'sjs') _root = sjsRoot;
    if (q.isEmpty) return _root.replace(path: path);
    return _root.replace(path: path, queryParameters: q);
  }

  @override
  Map<String, String> buildBody(Map<String, String> body) {
    return new Map<String, String>.from(body)..['access_token'] = accessToken;
  }
}
