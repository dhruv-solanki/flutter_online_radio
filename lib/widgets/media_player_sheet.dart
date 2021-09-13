import 'package:flutter/material.dart';
import 'package:flutter_online_radio/models/station.dart';
import 'package:flutter_online_radio/widgets/fevicon.dart';

class MediaPlayerSheet extends StatelessWidget {
  MediaPlayerSheet(
      {required this.station, required this.onPressed, required this.icon});

  final Station station;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 10,
          ),
          Fevicon(
            imageUrl: station.imageUrl,
            height: 50,
            width: 50,
          ),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Text(
              station.name,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          IconButton(
            icon: Icon(
              icon,
              size: 36,
            ),
            onPressed: onPressed,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
