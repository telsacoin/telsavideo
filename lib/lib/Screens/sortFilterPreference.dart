import 'package:flutter/material.dart';

class SortFilterPreferences extends ChangeNotifier {
  String? _sort;

  String? get sort => _sort;

  set sort(var value) {
    _sort = value;
    notifyListeners();
  }
}
