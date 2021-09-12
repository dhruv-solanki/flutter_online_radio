import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_online_radio/bloc/player_event.dart';
import 'package:flutter_online_radio/bloc/player_state.dart';
import 'package:flutter_online_radio/controller/radio_player.dart';

class RadioPlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  final RadioPlayer radioPlayer;

  RadioPlayerBloc({required this.radioPlayer}) : super(StoppedState());

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is PlayEvent) {
      yield* _handlePlayEvent(event);
    } else if (event is PauseEvent) {
      yield* _handlePauseEvent(event);
    }
  }

  Stream<PlayerState> _handlePlayEvent(PlayEvent event) async* {
    if (state is StoppedState) {
      _playNewRadioStation(event);
      yield PlayingState(currentStation: event.station);
    } else if (state is PausedState) {
      if ((state as PausedState).currentStation != event.station) {
        _playNewRadioStation(event);
      } else {
        _playExistingRadioStation(event);
      }
      yield PlayingState(currentStation: event.station);
    } else if (state is PlayingState) {
      if ((state as PlayingState).currentStation != event.station) {
        _playNewRadioStation(event);
      } else {
        _playExistingRadioStation(event);
      }
      yield PlayingState(currentStation: event.station);
    }
  }

  Stream<PlayerState> _handlePauseEvent(PlayerEvent event) async* {
    if (state is PlayingState) {
      radioPlayer.pause();
      yield PausedState(currentStation: (state as PlayingState).currentStation);
    }
  }

  void _playExistingRadioStation(PlayEvent event) {
    radioPlayer.play(url: event.station.stationUrl);
  }

  void _playNewRadioStation(PlayEvent event) {
    radioPlayer
        .setUrl(event.station.stationUrl)
        .then((_) => {radioPlayer.play(url: event.station.stationUrl)});
  }
}
