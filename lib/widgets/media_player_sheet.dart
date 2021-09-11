import 'package:flutter/material.dart';
import 'package:flutter_online_radio/controller/radio_player.dart';
import 'package:flutter_online_radio/widgets/fevicon.dart';

class MediaPlayerSheet extends StatefulWidget {
  MediaPlayerSheet({required this.station});

  final station;

  @override
  _MediaPlayerSheetState createState() => _MediaPlayerSheetState();
}

class _MediaPlayerSheetState extends State<MediaPlayerSheet> {
  bool isPlaying = false;
  late RadioPlayer radioPlayer;

  @override
  initState() {
    super.initState();
    setRadio();
  }

  setRadio() async {
    radioPlayer = RadioPlayer();
    try {
      await radioPlayer.setUrl(widget.station.stationUrl);
      print(widget.station.stationUrl);
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.black26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Fevicon(
            imageUrl: widget.station.imageUrl,
            height: 50,
            width: 50,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              widget.station.name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          (isPlaying)
              ? IconButton(
                  icon: Icon(
                    Icons.pause,
                    size: 32,
                  ),
                  onPressed: () async {
                    await radioPlayer.pause();
                    setState(() {
                      this.isPlaying = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    size: 32,
                  ),
                  onPressed: () async {
                    setState(() {
                      this.isPlaying = true;
                    });
                    await radioPlayer.play(url: widget.station.stationUrl);
                  },
                ),
        ],
      ),
    );
  }
}
