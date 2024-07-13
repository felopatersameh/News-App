import 'package:dio/dio.dart';

// baseUrl: https://newsapi.org/
// method : v2/top-headlines
// ?
// country=eg&category=everything&apiKey=70c84b24f0b3416da405361d79906233
// ---------------------------------------------------------------------------------
// base url: https://gnews.io/api/
// v4/top-headlines
// ?
// country=eg&category=business&apikey=API_KEY
class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://newsapi.org/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(url , queryParameters: query);
  }

}
