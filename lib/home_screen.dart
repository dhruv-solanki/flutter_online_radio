import 'package:flutter/material.dart';
import 'package:flutter_online_radio/models/station.dart';

import 'package:flutter_online_radio/widgets/list_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final stations = STATIONS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Radio'),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: stations.length,
          itemBuilder: (context, index) {
            return ListCard(
              stations: stations,
              index: index,
            );
          },
        ),
      ),
    );
  }
}
