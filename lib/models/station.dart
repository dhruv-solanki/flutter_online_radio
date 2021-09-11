class Station {
  const Station(
      {required this.stationUrl, required this.imageUrl, required this.name});

  final String stationUrl;
  final String imageUrl;
  final String name;
}

const STATIONS = const [
  Station(
    name: 'Radio Mirchi',
    imageUrl: 'http://www.radiomirchi.com/favicon.ico',
    stationUrl: 'http://peridot.streamguys.com:7150/Mirchi',
  ),
  Station(
    name: 'Non Stop Hindi Radio',
    imageUrl:
        'https://onlineradiofm.in/assets/image/radio/180/non-stop-hindi-india.jpg',
    stationUrl: 'http://198.178.123.14:8216/;',
  ),
  Station(
    name: 'Radio Mirchi - Filmy Mirchi',
    imageUrl:
        'https://media.radiomirchi.com/onlinestation/banners/FilmyMirchi285.jpg',
    stationUrl:
        'https://filmymirchihdliv-lh.akamaihd.net/i/FilmyMirchiHDLive_1_1@336266/master.m3u8',
  ),
];
