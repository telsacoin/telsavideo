class CaptchaImageVo {
  String? img;
  String? code;
  bool? captchaOnOff;
  String? uuid;
  CaptchaImageVo({this.img, this.code, this.captchaOnOff, this.uuid});

  factory CaptchaImageVo.fromJson(Map<String, dynamic> json) => CaptchaImageVo(
        img: json["img"] == null ? null : json["img"],
        code: json["code"] == null ? null : json["code"],
        captchaOnOff:
            json["captchaOnOff"] == null ? null : json["captchaOnOff"],
        uuid: json["uuid"] == null ? null : json["uuid"],
      );

  Map<String, dynamic> toJson() => {};
}
