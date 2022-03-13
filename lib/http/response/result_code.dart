enum ResultCode {
  SUCCESS,
  FAILURE,
}

extension ResultCodeExtension on ResultCode {
  static const labels = [200, 500];
  static const values = ["SUCCESS", "FAILURE"];

  int get label => labels[this.index];
  String get value => values[this.index];

  static ResultCode parse(int i) {
    return ResultCode.values[i];
  }
}
