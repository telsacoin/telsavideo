import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  SharedPreferences? prefs;
  String _query = '';
  List _recommendationList = [];
  List _communityResultList = [];
  List _podcastResultList = [];
  List _episodeResultList = [];
  bool _isPodcastSearchLoading = false;
  bool _isEpisodeSearchLoading = false;
  bool _isCommunitySearchLoading = false;

  //get query => _query;
  get recommendationList => _recommendationList;
  get podcastResultList => _podcastResultList;
  get episodeResultList => _episodeResultList;
/*   get isPodcastSearchLoading => _isPodcastSearchLoading;
  get isEpisodeSearchLoading => _isEpisodeSearchLoading;
  get isCommunitySearchLoading => _isCommunitySearchLoading; */
  get communityResultList => _communityResultList;

  set recommendationList(var newValue) {
    _recommendationList = newValue;
    notifyListeners();
  }

  set query(String newValue) {
    _query = newValue;
    notifyListeners();
  }

  set podcastResultList(var newValue) {
    _podcastResultList = newValue;
    notifyListeners();
  }

  set episodeResultList(var newValue) {
    _episodeResultList = newValue;
    notifyListeners();
  }

  set communityResultList(var newvalue) {
    notifyListeners();
  }

  set isEpisodeSearchLoading(bool newValue) {
    _isEpisodeSearchLoading = newValue;
    notifyListeners();
  }

  set isPodcastSearchLoading(bool newValue) {
    _isPodcastSearchLoading = newValue;
    notifyListeners();
  }

  set isCommunitySearchLoading(bool newValue) {
    _isCommunitySearchLoading = newValue;
    notifyListeners();
  }

  Future getSearch(String searchQuery) async {
    if (searchQuery != _query) {
      _query = searchQuery;
      prefs = await SharedPreferences.getInstance();
      String url =
          'https://api.aureal.one/public/search?user_id=&word=${_query}';

      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        // if (jsonDecode(response.body)['EpisodeList'] != null) {
        //   episodeResultList = jsonDecode(response.body)['EpisodeList'];
        // } else {
        //   episodeResultList = [];
        // }

        if (jsonDecode(response.body)['PodcastList'] != null) {
          podcastResultList = jsonDecode(response.body)['PodcastList'];
        } else {
          podcastResultList = [];
        }
      } else {
        print(response.statusCode);
      }
      isEpisodeSearchLoading = true;
      isPodcastSearchLoading = true;
      isCommunitySearchLoading = true;
    }
  }
  // isEpisodeSearchLoading = true;
  // isPodcastSearchLoading = true;
  // isCommunitySearchLoading = true;

}
