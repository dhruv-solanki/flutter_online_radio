import 'package:flutter_online_radio/models/station.dart';

abstract class PlayerEvent {}

class PlayEvent extends PlayerEvent {
  final Station station;
  PlayEvent({required this.station});
}

class PauseEvent extends PlayerEvent {}
