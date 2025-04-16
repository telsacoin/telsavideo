import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/category.dart';

// TODO: Finish implementation

/// An abstraction to extract category data from Steem
/// https://v2.steemconnect.com/docs/steemjs#api/
abstract class SteemCategoriesApi {
  /// Get information about trending categories
  /// https://api.steemjs.com/get_trending_categories?after=value&limit=value
  Future<List<Category>> getTrendingCategories({String? after, int? limit});

  /// Get information about best categories
  /// https://api.steemjs.com/get_best_categories?after=value&limit=value
  Future<List<Category>> getBestCategories({String? after, int? limit});

  /// Get information about active categories
  /// https://api.steemjs.com/get_active_categories?after=value&limit=value
  Future<List<Category>> getActiveCategories({String? after, int? limit});

  /// Get information about recent categories
  /// https://api.steemjs.com/get_recent_categories?after=value&limit=value
  Future<List<Category>> getRecentCategories({String? after, int? limit});

  /// Search for categories by name
  Future<List<Category>> search(String query);
}

class SteemCategories implements SteemCategoriesApi {
  static const String _baseUrl = 'https://api.steemjs.com';

  Future<List<Category>> getTrendingCategories(
      {String? after, int? limit}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/get_trending_categories?after=${after ?? ""}&limit=${limit ?? 20}'),
    );
    return (jsonDecode(response.body) as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<List<Category>> getBestCategories({String? after, int? limit}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/get_best_categories?after=${after ?? ""}&limit=${limit ?? 20}'),
    );
    return (jsonDecode(response.body) as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<List<Category>> getActiveCategories(
      {String? after, int? limit}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/get_active_categories?after=${after ?? ""}&limit=${limit ?? 20}'),
    );
    return (jsonDecode(response.body) as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<List<Category>> getRecentCategories(
      {String? after, int? limit}) async {
    final response = await http.get(
      Uri.parse(
          '$_baseUrl/get_recent_categories?after=${after ?? ""}&limit=${limit ?? 20}'),
    );
    return (jsonDecode(response.body) as List)
        .map((json) => Category.fromJson(json))
        .toList();
  }

  Future<List<Category>> search(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/get_trending_categories?limit=100'),
    );
    final categories = (jsonDecode(response.body) as List)
        .map((json) => Category.fromJson(json))
        .toList();

    return categories
        .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
