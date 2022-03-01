import 'dart:convert';
import 'package:http/http.dart';

class Ipfs {
  Ipfs({required this.host, this.noPort = false});

  void onInit() {}

  String host;
  bool noPort;

  final localhost = 'http://127.0.0.1';
  static String defHost = 'https://ipfs.infura.io';
  final apiPort = 5002;
  final webPort = 8080;
  final apiPath = '/api/v0/';
  final webPath = '/ipfs/';
  bool onLocal = false;

  String get apiUrl =>
      (onLocal ? localhost : (host ?? Ipfs.defHost)) +
      (noPort ? '' : (':' + apiPort.toString())) +
      apiPath;

  String get webUrl =>
      (onLocal ? localhost : (host ?? Ipfs.defHost)) +
      (noPort ? '' : (':' + webPort.toString())) +
      webPath;

  Future<Map<String, dynamic>> post(
      String cmd, dynamic c, MultipartFile f) async {
    if (!(c is String) && !(c is Map)) throw 'Wrong type of arguments';
    Map<String, dynamic> q =
        (c is String) ? {'arg': c} : c as Map<String, dynamic>;
    Uri uri = Uri.parse(apiUrl + cmd);
    var request = MultipartRequest(
      'POST',
      uri.replace(
        queryParameters: q,
      ),
    );

    if (f != null) request.files.add(f);

    final res = await request.send();
    final r = await res.stream.bytesToString();
    Map<String, dynamic> item = jsonDecode(r);

    return item;
  }

  Future<ByteStream> cat(url) async {
    final uri = Uri.parse(apiUrl + 'cat');
    Map<String, String> q = {
      'arg': url,
    };

    var request = Request('POST', uri.replace(queryParameters: q));

    final res = await request.send();
    return res.stream;
  }

  Future<String> add(MultipartFile f) async {
    var request = MultipartRequest(
      'POST',
      Uri.parse(apiUrl + 'add'),
    );

    request.files.add(f);
    final res = await request.send();
    final r = await res.stream.bytesToString();
    Map<String, dynamic> item = jsonDecode(r);
    print(r);
    return item['Hash'];
  }

  Future<ByteStream> put(dynamic d) async {
    final uri = Uri.parse(apiUrl + 'dag/put');
    Map<String, String> q = {};

    var request = Request(
      'POST',
      uri.replace(
        queryParameters: q,
      ),
    );
    request.bodyFields = d;

    final res = await request.send();
    return res.stream;
  }

  Future<Map<String, dynamic>> query(Request request) async {
    final res = await request.send();
    final r = await res.stream.bytesToString();
    return jsonDecode(r);
  }

  String parseUrl(String urla) {
    if (urla.length == 0) return '';
    final path = urla.split('://')[1];
    final url = webUrl + path;
    return url;
  }
}
