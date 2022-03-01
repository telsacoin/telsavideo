import 'package:telsavideo/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  bool isLightTheme;

  ThemeProvider({required this.isLightTheme});

  // the code below is to manage the status bar color when the theme changes
  getCurrentStatusNavigationBarColor() {
    if (isLightTheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: kPrimaryColor,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ));
    }
  }

  // use to toggle the theme
  toggleThemeData() async {
    final settings = await Hive.openBox('settings');
    settings.put('isLightTheme', !isLightTheme);
    isLightTheme = !isLightTheme;
    getCurrentStatusNavigationBarColor();
    notifyListeners();
  }

  // Global theme data we are always check if the light theme is enabled #isLightTheme
  ThemeData themeData() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      accentColor: Colors.blue,
      primarySwatch: isLightTheme ? Colors.grey : Colors.grey,
      primaryColor: isLightTheme ? Colors.white : kPrimaryColor,
      //  primaryColor: isLightTheme ? Colors.white : kPrimaryColor,
      brightness: isLightTheme ? Brightness.light : Brightness.dark,
      backgroundColor: isLightTheme ? Color(0xFFFFFFFF) : kPrimaryColor,

      scaffoldBackgroundColor: isLightTheme ? Color(0xFFFFFFFF) : kPrimaryColor,
      canvasColor: isLightTheme ? Color(0xffffffff) : kPrimaryColor,
    );
  }

  // Theme mode to display unique properties not cover in theme data
  ThemeColor themeMode() {
    return ThemeColor(
      gradient: [
        if (isLightTheme) ...[Color(0xDDFF0080), Color(0xDDFF8C00)],
        if (!isLightTheme) ...[Color(0xFF8983F7), Color(0xFFA3DAFB)]
      ],
      textColor: isLightTheme ? kPrimaryColor : Color(0xFFFFFFFF),
      toggleButtonColor: isLightTheme ? Color(0xFFFFFFFF) : Color(0xFf34323d),
      toggleBackgroundColor: isLightTheme ? Color(0xFFe7e7e8) : kPrimaryColor,
      shadow: [
        if (isLightTheme)
          BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 5)),
        if (!isLightTheme)
          BoxShadow(
              color: Color(0xFFd8d7da),
              spreadRadius: 10,
              blurRadius: 10,
              offset: Offset(0, 5))
      ],
    );
  }
}

// A class to manage specify colors and styles in the app not supported by theme data
class ThemeColor {
  List<Color>? gradient;
  Color? backgroundColor;
  Color? toggleButtonColor;
  Color? toggleBackgroundColor;
  Color? textColor;
  Color? iconTheme;
  List<BoxShadow>? shadow;

  ThemeColor(
      {this.gradient,
      this.backgroundColor,
      this.toggleBackgroundColor,
      this.toggleButtonColor,
      this.textColor,
      this.shadow,
      this.iconTheme});
}

class ZAnimatedToggle extends StatefulWidget {
  final List<String> values;
  final ValueChanged onToggleCallback;
  ZAnimatedToggle({
    Key? key,
    required this.values,
    required this.onToggleCallback,
  }) : super(key: key);
  @override
  _ZAnimatedToggleState createState() => _ZAnimatedToggleState();
}

class _ZAnimatedToggleState extends State<ZAnimatedToggle> {
  bool _isFavorited = true;
  int _favoriteCount = 41;
  // bool _smartNotifications = true; //value to be changed with the API
  //
  // bool _onChanged(bool value) {
  //   setState(() {
  //     _smartNotifications = value;
  //   });
  //   print(value.toString());
  // }
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }
  // Icon _notAffectedByStateChange = new Icon(
  //   Icons.thumb_up,
  //   color: Colors.grey,
  // );

  // _thisWillNotAffectTheState() {
  //   _affectedByStateChange = new Icon(Icons.thumb_up, color: Colors.blue);
  // }
  //
  // _thisWillNeitherAffectTheState() {
  //   _affectedByStateChange = new Icon(Icons.favorite, color: Colors.red);
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              icon: (_isFavorited ? Icon(Icons.wb_sunny) : Icon(Icons.bedtime)),
              color: Colors.blue,
              onPressed: () {
                widget.onToggleCallback(1);
                _toggleFavorite();
              }),
        ),
      ],
    );
  }
}
//     return  Switch(
//
//            value: _smartNotifications,
//         onChanged: (bool value) {
//           widget.onToggleCallback(1);
//         },
//       // child: Stack(
//       //   children: [
//       //     GestureDetector(
//       //       onTap: () {
//       //         widget.onToggleCallback(1);
//       //       },
//       //       child:
//             // child: Container(
//             //   width: width * .7,
//             //   height: width * .13,
//             //   decoration: ShapeDecoration(
//             //       color: themeProvider.themeMode().toggleBackgroundColor,
//             //       shape: RoundedRectangleBorder(
//             //           borderRadius: BorderRadius.circular(width * .1))),
//             //   // child: Row(
//             //   //   children: List.generate(
//             //   //     widget.values.length,
//             //   //     (index) => Padding(
//             //   //       padding: EdgeInsets.symmetric(horizontal: width * .1),
//             //   //       child: Text(
//             //   //         widget.values[index],
//             //   //         style: TextStyle(
//             //   //             fontSize: width * .05,
//             //   //             fontWeight: FontWeight.bold,
//             //   //             ),
//             //   //       ),
//             //   //     ),
//             //   //   ),
//             //   // ),
//             // ),
//        //   ),
//         //  )]
//           // AnimatedAlign(
//           //   alignment: themeProvider.isLightTheme
//           //       ? Alignment.centerLeft
//           //       : Alignment.centerRight,
//           //   duration: Duration(milliseconds: 350),
//           //   curve: Curves.ease,
//           //   child: Container(
//           //     alignment: Alignment.center,
//           //     width: width * .35,
//           //     height: width * .13,
//              //  decoration: ShapeDecoration(
//              // //     color: themeProvider.themeMode().toggleButtonColor,
//              //    //  shadows: themeProvider.themeMode().shadow,
//              //      shape: RoundedRectangleBorder(
//              //          borderRadius: BorderRadius.circular(width * .1))),
//               // child: Text(
//               //   themeProvider.isLightTheme
//               //       ? widget.values[0]
//               //       : widget.values[1],
//               //   style: TextStyle(
//               //       fontSize: width * .045, fontWeight: FontWeight.bold),
//               // ),
//           //  ),
//         //  )
//       //   ],
//       // ),
//     );
//   }
// }
