import 'package:dio/dio.dart';

class DioProvider {
  static late Dio _dio;

  static init() {
    _dio = Dio(BaseOptions(
      baseUrl: "https://codingarabic.online/api/",
    ));
  }

  static Future<Response> get(
      {required String endpoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.get(
      endpoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> post(
      {required String endpoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.post(
      endpoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> update(
      {required String endpoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.put(
      endpoint,
      data: params,
      options: Options(headers: headers),
    );
  }

  static Future<Response> delete(
      {required String endpoint,
      Map<String, dynamic>? params,
      Map<String, dynamic>? headers}) async {
    return await _dio.delete(
      endpoint,
      data: params,
      options: Options(headers: headers),
    );
  }
}
