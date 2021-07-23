import 'package:dio/dio.dart';

/// The base network client.
///
/// This is basically a wrapper around the `Dio` package since the application
/// package doesn't need to know about the client.
///
/// In a real case scenario this client would handle things like `Tokens`,
/// `Interceptors`, `Headers` and etc.
class Netclient {
  final Dio _dio;

  /// Creates a new `Netclient` instance.
  Netclient({
    required String baseUrl,
  }) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  /// `GET` request of this netclient.
  Future<Response<T>> get<T>({
    required String path,
  }) {
    return _dio.get<T>(path);
  }
}
