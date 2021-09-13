import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_online_radio/screens/splash_screen.dart';

class MyHttpOverrides extends HttpOverrides {
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(RadioApp());
}

class RadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Radio',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
