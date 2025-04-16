import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:telsavideo/api/category.dart';
import 'package:telsavideo/models/category.dart';
import 'package:telsavideo/services/requestor.dart';

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
    final response = await requestor.request(
      'sjs',
      '/get_trending_categories?after=${after ?? ""}&limit=${limit ?? 20}',
    );
    return (response.data as List).map((m) => Category.fromJson(m)).toList();
  }

  @override
  Future<List<Category>> getBestCategories({String? after, int? limit}) async {
    final response = await requestor.request(
      'sjs',
      '/get_best_categories?after=${after ?? ""}&limit=${limit ?? 20}',
    );
    return (response.data as List).map((m) => Category.fromJson(m)).toList();
  }

  @override
  Future<List<Category>> getActiveCategories(
      {String? after, int? limit}) async {
    final response = await requestor.request(
      'sjs',
      '/get_active_categories?after=${after ?? ""}&limit=${limit ?? 20}',
    );
    return (response.data as List).map((m) => Category.fromJson(m)).toList();
  }

  @override
  Future<List<Category>> getRecentCategories(
      {String? after, int? limit}) async {
    final response = await requestor.request(
      'sjs',
      '/get_recent_categories?after=${after ?? ""}&limit=${limit ?? 20}',
    );
    return (response.data as List).map((m) => Category.fromJson(m)).toList();
  }

  @override
  Future<List<Category>> search(String query) async {
    final response = await requestor.request(
      'sjs',
      '/get_trending_categories?limit=100',
    );
    final categories =
        (response.data as List).map((m) => Category.fromJson(m)).toList();

    return categories
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
