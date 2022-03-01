import 'package:telsavideo/api/category.dart';
import 'package:telsavideo/services/requestor.dart';

// TODO: Finish implementation

class SteemCategoriesApiImpl implements SteemCategoriesApi {
  static const String _trendingRoot = '/get_trending_categories';
  static const String _bestRoot = '/get_best_categories';
  static const String _activeRoot = '/get_active_categories';
  static const String _recentRoot = '/get_recent_categories';

  final Requestor requestor;

  SteemCategoriesApiImpl(this.requestor);

/*
  @override
  Future<Category> getTrendingCategories({String after, int limit});
  */

/*
  @override
  //Future<Category> getBestCategories({String after, int limit});
  */

/*
  @override
  //Future<Category> getActiveCategories({String after, int limit});
  */

/*
  @override
  //Future<Category> getRecentCategories({String after, int limit});
  */

/*
  @override
  //FFuture<List<Category>> search(String query);
  */

}
