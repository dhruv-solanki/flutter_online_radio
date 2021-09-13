import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_radio/bloc/player_event.dart';
import 'package:flutter_online_radio/bloc/player_state.dart';
import 'package:flutter_online_radio/bloc/radio_player_bloc.dart';
import 'package:flutter_online_radio/controller/radio_browser.dart';
import 'package:flutter_online_radio/models/station.dart';
import 'package:flutter_online_radio/widgets/error_screen.dart';

import 'package:flutter_online_radio/widgets/list_card.dart';
import 'package:flutter_online_radio/widgets/media_player_sheet.dart';
import 'package:flutter_online_radio/widgets/radio_status.dart';
import 'package:flutter_online_radio/widgets/waiting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final stations = STATIONS;
  RadioBrowser _radioBrowser = RadioBrowser(dio: Dio());
  late List<Station> stations;
  bool isPlayerInit = false;

  initialize() async {
    final String _countryCode = 'in';
    final int offset = 0;
    final int limit = 15;

    try {
      stations = await _radioBrowser.getStationsByCountry(
        _countryCode,
        offset,
        limit,
      );
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online Radio'),
          actions: [
            BlocBuilder<RadioPlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PausedState || state is StoppedState) {
                  return PausedStatus();
                } else {
                  return PlayingStatus();
                }
              },
            )
          ],
        ),
        body: Container(
          child: FutureBuilder(
            future: initialize(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return WaitingScreen();
              } else {
                if (snapshot.hasError) {
                  return ErrorScreen(
                    onPressed: () {
                      setState(() {
                        initialize();
                      });
                    },
                  );
                } else {
                  return Container(
                    height: (isPlayerInit)
                        ? MediaQuery.of(context).size.height * 0.77
                        : MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: stations.length,
                      // padding: EdgeInsets.only(
                      //   bottom: 70,
                      // ),
                      itemBuilder: (context, index) {
                        return ListCard(
                          stations: stations,
                          index: index,
                          onTap: () {
                            setState(() {
                              isPlayerInit = true;
                            });
                            BlocProvider.of<RadioPlayerBloc>(context)
                                .add(PlayEvent(station: stations[index]));
                          },
                        );
                      },
                    ),
                  );
                }
              }
            },
          ),
        ),
        bottomSheet: BlocBuilder<RadioPlayerBloc, PlayerState>(
          builder: (context, state) {
            if (state is StoppedState) {
              return SizedBox();
            } else if (state is PlayingState) {
              final currentStation = state.currentStation;

              return MediaPlayerSheet(
                station: currentStation,
                icon: Icons.pause,
                onPressed: () {
                  BlocProvider.of<RadioPlayerBloc>(context).add(PauseEvent());
                },
              );
            } else {
              final currentStation = (state as PausedState).currentStation;

              return MediaPlayerSheet(
                station: currentStation,
                icon: Icons.play_arrow,
                onPressed: () {
                  BlocProvider.of<RadioPlayerBloc>(context)
                      .add(PlayEvent(station: currentStation));
                },
              );
            }
          },
        ));
  }
}
