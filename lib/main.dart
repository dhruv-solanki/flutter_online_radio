import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_radio/bloc/radio_player_bloc.dart';
import 'package:flutter_online_radio/controller/radio_player.dart';
import 'package:flutter_online_radio/home_screen.dart';

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
    final RadioPlayer radioPlayer = RadioPlayer();

    return MaterialApp(
      title: 'Online Radio',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<RadioPlayerBloc>(
            create: (context) => RadioPlayerBloc(radioPlayer: radioPlayer),
          )
        ],
        child: HomeScreen(),
      ),
    );
  }
}
