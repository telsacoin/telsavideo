import 'package:platform/platform.dart';

class BaseDto {
  int? aid;
  String? app_name;
  String? device_platform;
  int? device_id;
  String? region;
  String? priority_region;
  String? os;
  String? referer;
  String? root_referer;
  bool? cookie_enabled;
  String? screen_width;
  String? screen_height;
  String? browser_language;
  String? browser_platform;

  BaseDto() {
    BaseDto.getInstance();
  }

  ///singleton instance
  static BaseDto? _instance;

  static _getInstance() {
    if (null == _instance) {
      _instance = BaseDto._internal();
    }
    return _instance;
  }

  factory BaseDto.getInstance() => _getInstance();

  BaseDto._internal() {
    aid = 1989;
    app_name = "DTOK";
    device_platform = Platform.operatingSystemValues.first;
    device_id = null;
  }
}
