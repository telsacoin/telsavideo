import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getflutter/components/loader/gf_loader.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:getflutter/types/gf_loader_type.dart';

// the loading widget
//common widget
// ignore: non_constant_identifier_names
Widget get Loading => Container(
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
Widget get Sloading => Container(
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
