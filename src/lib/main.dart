// ADD THIS IMPORT
import 'dart:async';
import 'dart:io';
//import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:telsavideo/appBehaviour/my_behaviour.dart';
import 'package:telsavideo/screens/settings/security/theme.dart';
import 'package:telsavideo/screens/splashScreen.dart';
//import 'package:country_codes/country_codes.dart';
import 'components/api.dart';
import 'package:stack_trace/stack_trace.dart';

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
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<Null> main() async {
  //ensure the app initial
  WidgetsFlutterBinding.ensureInitialized();
  //await CountryCodes.init();
  if (kDebugMode) {
    Chain.capture(() {});
  }

  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    final appDocumentDirectory =
        await pathProvider.getApplicationDocumentsDirectory();
    /* await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      ); */
    Hive.init(appDocumentDirectory.path);
  }

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FlutterError.onError = (FlutterErrorDetails details) async {
    if (!kReleaseMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
    }
  };

  final settings = await Hive.openBox('settings');
  bool isLightTheme = settings.get('isLightTheme') ?? false;

  print(isLightTheme);

  runZoned<Future<Null>>(() async {
    // ADD THIS LINE
    //debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});

    var _temp = {"user": await retrieveData("user")};
    var user = _temp["user"];

    // set theme
    var _tempTheme = await retrieveData("theme");
    if (_tempTheme != null && _tempTheme != "value") {
      print(_tempTheme);
      selectedTheme = _tempTheme;
    } else {
      selectedTheme = "normal";
    }

    var internet = true;

    // first start
    dynamic _tempBuildNumber = "0";
    int buildNumber = 1;
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      buildNumber = int.parse(packageInfo.buildNumber);
      //tempBuildNumber = await retrieveData("buildNumber");
    } catch (e) {}

    if (_tempBuildNumber == null ||
        int.parse(_tempBuildNumber) < buildNumber && user == null) {
      saveData("gateway", "https://video.telsacoin.io/ipfs/");
      saveData("buildNumber", buildNumber.toString());
      runApp(ChangeNotifierProvider(
        create: (_) => ThemeProvider(isLightTheme: isLightTheme),
        child: AppStart(),
      ));
    } else {
      runApp(ChangeNotifierProvider(
        create: (_) => ThemeProvider(isLightTheme: isLightTheme),
        child: AppStart(),
      ));
    }

    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }, onError: (error, stackTrace) async {
    await _reportError(error, stackTrace);
  });
}

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('{$error $stackTrace}');
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
      Scaffold.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  late AppUpdateInfo _updateInfo;
  Future<void> checkForUpdate() async {
    try {
      if (Platform.isAndroid) {
        InAppUpdate.checkForUpdate().then((info) {
          setState(() {
            _updateInfo = info;
          });
          // ignore: invalid_return_type_for_catch_error
        }).catchError((error) => print(error));

        if (_updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate()
              .catchError((error) => print(error));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    //check the update when app is ready to start
    checkForUpdate();
    // TODO: implement initState
    super.initState();
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
      home: SplashScreen(),
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('he', 'IL'), // Hebrew
        const Locale('zh', 'CN'),
        // ... other locales the app supports
      ],
      //debugShowCheckedModeBanner: true,
      title: 'DTok',
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
