import 'package:url_launcher/url_launcher.dart';

class Launcher {
  Launcher();

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}
