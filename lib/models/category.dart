class Category {
  final String name;
  final int discussions;
  final String lastPost;
  final double totalPayouts;

  Category({
    required this.name,
    required this.discussions,
    required this.lastPost,
    required this.totalPayouts,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'] as String,
      discussions: json['discussions'] as int,
      lastPost: json['last_post'] as String,
      totalPayouts: (json['total_payouts'] as num).toDouble(),
    );
  }
}
