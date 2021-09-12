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
import 'package:flutter_online_radio/widgets/waiting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // final stations = STATIONS;
  RadioBrowser _radioBrowser = RadioBrowser(dio: Dio());
  late List<Station> stations;

  @override
  void initState() {
    super.initState();
  }

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
                  return ListView.builder(
                    itemCount: stations.length,
                    itemBuilder: (context, index) {
                      return ListCard(
                        stations: stations,
                        index: index,
                        onTap: () {
                          BlocProvider.of<RadioPlayerBloc>(context)
                              .add(PlayEvent(station: stations[index]));
                        },
                      );
                    },
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
