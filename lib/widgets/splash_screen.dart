import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_radio/bloc/radio_player_bloc.dart';
import 'package:flutter_online_radio/controller/radio_player.dart';
import 'package:flutter_online_radio/home_screen.dart';
import 'package:flutter_online_radio/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final RadioPlayer radioPlayer = RadioPlayer();

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Radio App',
                style: TextStyle(
                  fontSize: 50,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Created with ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.favorite,
                      ),
                    ),
                    TextSpan(
                      text: ' Dhruv Solanki',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                ),
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider<RadioPlayerBloc>(
                            create: (context) =>
                                RadioPlayerBloc(radioPlayer: radioPlayer),
                          ),
                        ],
                        child: HomeScreen(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
