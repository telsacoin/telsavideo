class BannerVo {
  String? image;
  String? title;
  String? url;

  BannerVo({this.image, this.title, this.url});
  factory BannerVo.toJson(Map<String, dynamic> json) => BannerVo();
}
