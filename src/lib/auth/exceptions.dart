library steam_login.exceptions;

enum OpenIdFailReason { param, params, body, noBody, pattern, invalid }

class OpenIdException implements Exception {
  final String message;
  final String param;
  final OpenIdFailReason reason;

  OpenIdException(this.reason, [this.message = '', this.param]);

  @override
  String toString() {
    if (param == null) {
      return 'OpenIdException: $message (Reason: ${reason.toString()}';
    } else {
      return 'OpenIdException: Param: $param $message '
          '(Reason ${reason.toString()}';
    }
  }
}

class ApiKeyException implements Exception {
  final String key;

  ApiKeyException(this.key);

  @override
  String toString() => 'Invalid Steam API Key: $key';
}
