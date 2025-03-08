import 'package:telsavideo/api/category.dart';
import 'package:telsavideo/services/requestor.dart';
import 'package:telsavideo/models/category.dart';

// TODO: Finish implementation

class SteemCategoriesApiImpl implements SteemCategoriesApi {
  static const String _trendingRoot = '/get_trending_categories';
  static const String _bestRoot = '/get_best_categories';
  static const String _activeRoot = '/get_active_categories';
  static const String _recentRoot = '/get_recent_categories';

  final Requestor requestor;

  SteemCategoriesApiImpl(this.requestor);

  @override
  Future<List<Category>> getTrendingCategories(
      {String? after, int? limit}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getBestCategories({String? after, int? limit}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getActiveCategories(
      {String? after, int? limit}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> getRecentCategories(
      {String? after, int? limit}) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> search(String query) async {
    throw UnimplementedError();
  }

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
