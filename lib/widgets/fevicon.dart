import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Fevicon extends StatelessWidget {
  Fevicon({required this.stations, required this.index});

  final stations;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      child: CachedNetworkImage(
        imageUrl: stations[index].imageUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, err) => Icon(Icons.error),
      ),
    );
  }
}
