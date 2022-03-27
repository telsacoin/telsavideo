class DiscoverMusicVo {
  DiscoverMusicVo({
    required this.musicInfoList,
  });

  late final List<MusicInfoList> musicInfoList;

  DiscoverMusicVo.fromJson(Map<String, dynamic> json) {
    musicInfoList = List.from(json['musicInfoList'])
        .map((e) => MusicInfoList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['musicInfoList'] = musicInfoList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class MusicInfoList {
  MusicInfoList({
    required this.music,
    required this.stats,
  });
  late final Music music;
  late final Stats stats;

  MusicInfoList.fromJson(Map<String, dynamic> json) {
    music = Music.fromJson(json['music']);
    stats = Stats.fromJson(json['stats']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['music'] = music.toJson();
    _data['stats'] = stats.toJson();
    return _data;
  }
}

class Music {
  Music({
    required this.album,
    required this.authorName,
    required this.coverLarge,
    required this.coverMedium,
    this.coverThumb,
    required this.duration,
    required this.id,
    required this.original,
    this.playUrl,
    required this.title,
  });
  late final String album;
  late final String authorName;
  late final String coverLarge;
  late final String coverMedium;
  late final String? coverThumb;
  late final String duration;
  late final String id;
  late final String original;
  late final String? playUrl;
  late final String title;

  Music.fromJson(Map<String, dynamic> json) {
    album = json['album'];
    authorName = json['authorName'];
    coverLarge = json['coverLarge'];
    coverMedium = json['coverMedium'];
    coverThumb = null;
    duration = json['duration'];
    id = json['id'];
    original = json['original'];
    playUrl = null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['album'] = album;
    _data['authorName'] = authorName;
    _data['coverLarge'] = coverLarge;
    _data['coverMedium'] = coverMedium;
    _data['coverThumb'] = coverThumb;
    _data['duration'] = duration;
    _data['id'] = id;
    _data['original'] = original;
    _data['playUrl'] = playUrl;
    _data['title'] = title;
    return _data;
  }
}

class Stats {
  Stats({
    this.videoCount,
    this.viewCount,
  });
  late final Null videoCount;
  late final Null viewCount;

  Stats.fromJson(Map<String, dynamic> json) {
    videoCount = null;
    viewCount = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['videoCount'] = videoCount;
    _data['viewCount'] = viewCount;
    return _data;
  }
}
