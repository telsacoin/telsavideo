import 'package:flutter/material.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';

// the loading widget
//common widget
Widget get loading => Container(
      color: Colors.black,
      child: Center(
        child: GFLoader(
          type: GFLoaderType.circle,
          loaderColorOne: Colors.blueAccent,
          loaderColorTwo: Colors.white,
          loaderColorThree: Colors.pink,
        ),
      ),
    );

// the small loading
Widget get sloading => Container(
      width: 48,
      height: 48,
      color: Colors.black,
      child: Center(
        child: GFLoader(
          type: GFLoaderType.circle,
          loaderColorOne: Colors.blueAccent,
          //loaderColorTwo: Colors.white,
          loaderColorThree: Colors.pink,
        ),
      ),
    );

// the error widget
Widget get empty => Container(
      width: 48,
      height: 48,
      color: Colors.black,
      child: Center(child: Text('Error,Please restart your app again.')),
    );
