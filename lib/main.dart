import 'package:chrome/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>
       MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/':(context) => Home_Screem(),
        },
      ),
    )
  );
}

