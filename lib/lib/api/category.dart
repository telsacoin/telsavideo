

// TODO: Finish implementation

/// An abstraction to extract category data from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemCategoriesApi {

  /// Get information about trending categories
  /// https://api.steemjs.com/get_trending_categories?after=value&limit=value
  //Future<Category> getTrendingCategories({String after, int limit});

  /// Get information about best categories
  /// https://api.steemjs.com/get_best_categories?after=value&limit=value
  //Future<Category> getBestCategories({String after, int limit});

  /// Get information about active categories
  /// https://api.steemjs.com/get_active_categories?after=value&limit=value
  //Future<Category> getActiveCategories({String after, int limit});

  /// Get information about recent categories
  /// https://api.steemjs.com/get_recent_categories?after=value&limit=value
  //Future<Category> getRecentCategories({String after, int limit});

  /// Search for categories by name
  //Future<List<Category>> search(String query);
}