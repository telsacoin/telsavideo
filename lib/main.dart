// ADD THIS IMPORT
import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telsavideo/appBehaviour/my_behaviour.dart';
import 'package:telsavideo/screens/settings/security/theme.dart';
import 'package:telsavideo/screens/splashScreen.dart';
import 'components/core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telsavideo/firebase_options.dart';

var videoData;

// analytics
//FirebaseAnalytics analytics = new FirebaseAnalytics();
var pubIndex = 0;

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  description:
      'This channel is used for important notifications.', // description
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ... 其他初始化代码
}

/// report the error th sentry
Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  await Sentry.captureException(
    error,
    stackTrace: stackTrace,
  );
}

class AppStart extends StatelessWidget {
  const AppStart({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MyApp(
      themeProvider: themeProvider,
    );
  }
}

class MyApp extends StatefulWidget with WidgetsBindingObserver {
  final ThemeProvider themeProvider;

  const MyApp({Key? key, required this.themeProvider}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _MyAppState extends State<MyApp> {
  bool? _flexibleUpdateAvailable = false;
  String? _token;

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  AppUpdateInfo? _updateInfo;
  Future<void> checkForUpdate() async {
    try {
      if (Platform.isAndroid) {
        InAppUpdate.checkForUpdate().then((info) {
          setState(() {
            _updateInfo = info;
          });
        }).catchError((e) {
          showSnack(e.toString());
        });

        if (_updateInfo != null &&
            _updateInfo!.updateAvailability ==
                UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate().catchError((e) {
            showSnack(e.toString());
          });
        }
      }
    } catch (e) {
      print("AppUpdateInfo:" + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //check the update when app is ready to start
    checkForUpdate();
  }

  void _showSnackBar(String msg) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final context = _scaffoldKey.currentContext;
      if (context != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(msg),
        ));
      }
    });
  }

  int _messageCount = 0;

  final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)!.home_buttom_title,
      home: SplashScreen(),
      localeResolutionCallback: (
        Locale? locale,
        Iterable<Locale> supportedLocales,
      ) {
        return locale;
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.white,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primarySwatch: Colors.red,
        primaryColor: Colors.black,
        indicatorColor: Colors.white,
        tabBarTheme: TabBarTheme(),
      ),
      /* initialRoute: '/',
     onGenerateRoute: RouteGenerator.generateRoute, */
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
    );
  }
}
