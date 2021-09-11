import 'package:flutter/material.dart';
import 'package:flutter_online_radio/widgets/fevicon.dart';

class ListCard extends StatelessWidget {
  ListCard({required this.stations, required this.index});

  final stations;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
      ),
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Fevicon(
            imageUrl: stations[index].imageUrl,
            height: 48,
            width: 48,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              stations[index].name,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}