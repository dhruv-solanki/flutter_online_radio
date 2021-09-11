import 'package:just_audio/just_audio.dart';

class RadioPlayer {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<Duration?> setUrl(String url) async {
    return _audioPlayer.setUrl(url);
  }

  Future<void> play({required String url}) async {
    return _audioPlayer.play();
  }

  Future<void> pause() async {
    return _audioPlayer.pause();
  }
}
