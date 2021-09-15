/// The Episode model.
/// Represents a Episode.
class Episode {
  int? id;
  int? episodeId;
  String? taskId;
  String? name;
  String? podcastName;
  String? summary;
  String? image;

  /// Default constructor.
  Episode({
    this.id,
    this.episodeId,
    this.taskId,
    this.name,
    this.podcastName,
    this.summary,
    this.image,
  });

  /// Constructs this object from a json object.
  Episode.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    episodeId = data['episodeId'];
    taskId = data['taskId'];
    name = data['name'];
    podcastName = data['podcastName'];
    summary = data['summary'];
    image = data['image'];
  }

  /// Gets the json representation of this object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'episodeId': episodeId,
      'taskId': taskId,
      'name': name,
      'podcastName': podcastName,
      'summary': summary,
      'image': image,
    };
  }

  /// Gets the object at specified key.
  /// This doesn't return the object reference. Instead it returns a clone.
  dynamic operator [](String key) => toJson()[key];
}
