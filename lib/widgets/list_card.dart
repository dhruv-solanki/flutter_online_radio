import 'package:flutter/material.dart';
import 'package:flutter_online_radio/widgets/fevicon.dart';

class ListCard extends StatelessWidget {
  ListCard({required this.stations, required this.index, required this.onTap});

  final stations;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        margin: EdgeInsets.all(3),
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
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
