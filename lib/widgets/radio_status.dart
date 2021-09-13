import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PausedStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dots = List.generate(5, (_) {
      return Container(
        margin: EdgeInsets.all(1),
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).accentColor,
        ),
        height: 4,
        width: 4,
      );
    });

    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: dots,
      ),
    );
  }
}

class PlayingStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 20),
      margin: EdgeInsets.only(
        top: 10,
        left: 10,
        bottom: 10,
      ),
      child: LoadingIndicator(
        indicatorType: Indicator.lineScalePulseOutRapid,
        colors: [Theme.of(context).accentColor],
      ),
    );
  }
}
