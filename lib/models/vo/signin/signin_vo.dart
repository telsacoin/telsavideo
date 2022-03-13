/// the telsacoin
/// author:cw

class SignInVo {
  String? accessToken;
  int? expiresIn;
  DateTime? expiresInDate;
  String? permitToken;
  String? refreshToken;
  String? token;
  String? userInfo;
  String? userName;

  SignInVo({
    this.accessToken,
    this.expiresIn,
    this.expiresInDate,
    this.permitToken,
    this.refreshToken,
    this.token,
    this.userInfo,
    this.userName,
  });

  factory SignInVo.fromJson(Map<String, dynamic> json) => SignInVo(
        accessToken: json["accessToken"] == null ? null : json["accessToken"],
        expiresIn: json["expiresIn"] == null ? null : json["expiresIn"],
        expiresInDate:
            json["expiresInDate"] == null ? null : json["expiresInDate"],
        permitToken: json["permitToken"] == null ? null : json["permitToken"],
        refreshToken:
            json["refreshToken"] == null ? null : json["refreshToken"],
        token: json["token"] == null ? null : json["token"],
        userInfo: json["userInfo"] == null ? null : json["userInfo"],
        userName: json["userName"] == null ? null : json["userName"],
      );

  Map<String, dynamic> toJson() => {};
}
