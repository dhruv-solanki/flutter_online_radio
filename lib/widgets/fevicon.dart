import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Fevicon extends StatelessWidget {
  Fevicon({required this.imageUrl, required this.height, required this.width});

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          color: Colors.grey,
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, err) => Icon(Icons.error),
        ),
      ),
    );
  }
}
