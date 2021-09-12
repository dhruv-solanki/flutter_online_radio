import 'package:flutter_online_radio/models/station.dart';

abstract class PlayerState {}

class PlayingState extends PlayerState {
  final Station currentStation;
  PlayingState({required this.currentStation});
}

class PausedState extends PlayerState {
  final Station currentStation;
  PausedState({required this.currentStation});
}

class StoppedState extends PlayerState {}
