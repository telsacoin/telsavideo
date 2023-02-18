class Result<T> {
  int? code;
  String? msg;
  bool? status;
  T? data;

  Result(this.code, this.msg, this.status, this.data);

  static Result success<T>(int code, String msg, T data) {
    Result<T> result = new Result<T>(code, msg, true, data);
    result.code = code;
    result.msg = msg;
    result.data = data;
    result.status = true;
    return result;
  }

  Result.fromJson(Map<String, dynamic>? json) {
    code = json!['code'];
    msg = json['msg'];
    data = json['data'];
    status = json['success'];
  }
}
