import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_online_radio/models/station.dart';

class RadioBrowser {
  final Dio dio;
  static final String _baseUrl = 'https://fr1.api.radio-browser.info';
  static final String _stationsByCountryCodeUrl =
      '$_baseUrl/json/stations/bycountrycodeexact/';

  final String nullImageUrl =
      'https://png.pngtree.com/png-clipart/20200811/ourlarge/pngtree-retro-radio-listen-to-music-radio-broadcast-png-image_2323115.jpg';

  RadioBrowser({required this.dio});

  // RadioBrowser(this._dio) {
  //   _dio.interceptors.add(
  //     DioCacheManager(
  //       CacheConfig(
  //         baseUrl: _baseUrl,
  //       ),
  //     ).interceptor,
  //   );
  // }

  Future<List<Station>> getStationsByCountry(
      String countryCode, int offset, int limit) async {
    final stationsFromCountryCodeUrl = _stationsByCountryCodeUrl + countryCode;

    final Response rawStationsJson = await dio.get(
      _buildUrlToSortByPopularity(stationsFromCountryCodeUrl, offset, limit),
      options: buildCacheOptions(
        Duration(days: 1),
      ),
    );

    final List<Station> stations = (rawStationsJson.data as List)
        .map((responseJson) => Station(
              stationUrl: responseJson['url_resolved'],
              imageUrl: responseJson['fevicon'] ??= nullImageUrl,
              name: responseJson['name'],
            ))
        .toList();

    return Future.value(stations);
  }

  String _buildUrlToSortByPopularity(String url, int offset, int limit) {
    return '$url?hidebroken=true&order=clickcount&reverse=true&offset=$offset&limit=$limit';
  }
}
