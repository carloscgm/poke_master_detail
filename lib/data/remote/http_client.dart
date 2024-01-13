import 'package:dio/dio.dart';
import 'package:poke_master_detail/data/remote/interceptor/dio_logging_interceptor.dart';
import 'package:poke_master_detail/data/remote/network_endpoints.dart';

import 'credentials_wallet.dart';

class HttpClient {
  final Dio dio = Dio();

  static final HttpClient _httpClient = HttpClient._internal();

  factory HttpClient() {
    return _httpClient;
  }

  // https://github.com/flutterchina/dio/blob/develop/example/lib/queued_interceptor_crsftoken.dart
  // https://gist.github.com/TimurMukhortov/a1c9819e3779015e54bc3964b7d2308a
  HttpClient._internal() {
    dio.interceptors
      ..add(DioLoggingInterceptor())
      ..add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
        await _addAuthHeader(options.headers);
        handler.next(options);
      }, onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          // Refresh token and try again
          try {
            await _refreshToken();
            return handler.resolve(await _retry(error.requestOptions));
          } on DioException catch (error) {
            return handler.next(error);
          }
        }

        return handler.next(error);
      }));
  }

  Future<void> _addAuthHeader(Map<String, dynamic> headers) async {
    final refreshToken = await CredentialsWallet.getRefreshToken();
    final accessToken = await CredentialsWallet.getAccessToken();

    if (!refreshToken.isEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    } // You can also add basic authorization here
  }

  Future<void> _refreshToken() async {
    final refreshToken = await CredentialsWallet.getRefreshToken();
    final response = await Dio().post(NetworkEndpoints.refreshTokenUrl,
        data: {CredentialsWallet.refreshTokenKey: refreshToken});

    if (response.statusCode == 200) {
      await CredentialsWallet.saveAll(response.data);
    } else {
      await CredentialsWallet.clearAll();
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final headers = requestOptions.headers;
    await _addAuthHeader(headers);
    final options = Options(method: requestOptions.method, headers: headers);

    return Dio().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
