class SignUpVO {
  String? message;

  SignUpVO([this.message]);

  factory SignUpVO.fromJson(Map<String, dynamic> json) => SignUpVO();
}
