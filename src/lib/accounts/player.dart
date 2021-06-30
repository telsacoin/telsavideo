library steam_login.player;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'exceptions.dart';

/// Calls the [GetPlayerSummaries] SteamAPI, and returns a Map containing the data
/// Listed on https://developer.valvesoftware.com/wiki/Steam_Web_API#GetPlayerSummaries_.28v0002.29
/// Throws a Generic
Future<Map<String, dynamic>> GetPlayerSummaries(
    String steamid, String apikey) async {
  final url =
      'https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=$apikey&steamids=$steamid';
  var resp = await http.get(Uri.parse(url));
  if (resp.statusCode == 403) {
    throw ApiKeyException(apikey);
  }

  return jsonDecode(resp.body)['response']['players'][0];
}
