import 'dart:io';

import 'package:telsavideo/auth/steam_login.dart';

Future<void> main() async {
  // Bind the HttpServer.
  var server = await HttpServer.bind(
    InternetAddress.loopbackIPv4,
    80,
  );

  // Start listening for HttpRequests.
  server.listen((request) async {
    //Check if the path is '/login'
    if (request.uri.path == '/login') {
      // Create OpenId instance with the current request.
      OpenId openId = OpenId(request);

      // Switch the mode
      switch (openId.mode) {
        // No mode is set
        case '':
          {
            //Redirect the user to the authUrl.
            request.response
              ..redirect(openId.authUrl())
              ..close();
            break;
          }
        // Authentication failed/cancelled.
        case 'cancel':
          {
            request.response
              ..write('Auth cancelled')
              ..close();
            break;
          }
        // Usually mode = 'id_res'.
        default:
          {
            // Validate the authentication and the the steamid64.
            String? steamId = await openId.validate();

            // Save the steamid into the session.
            request.session['steamid'] = steamId;

            // Redirect the user.
            request.response
              ..redirect(Uri.parse('http://localhost'))
              ..close();
          }
      }
    } else {
      // Check if the user is already logged
      if (request.session['steamid'] == null) {
        request.response.write('Go to /login in order to log in!');
      } else {
        // If he's logged in display his steam display name.
        // Get the steamapi key here: https://steamcommunity.com/dev/apikey
        Map<String, dynamic> summaries = await GetPlayerSummaries(
            request.session['steamid'], 'yoursteamapikey');
        request.response
            .write('Thanks for logging in: ${summaries['personname']}');
      }
      request.response.close();
    }
  });
}
