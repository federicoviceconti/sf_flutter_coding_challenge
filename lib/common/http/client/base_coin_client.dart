import 'package:http/http.dart' as http;
import 'package:sf_flutter_coding_challenge/common/http/model/base_http_response.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/http_result.dart';

abstract class BaseCoinClient {
  final String basePath;
  final String apiKey;

  BaseCoinClient({
    required this.basePath,
    required this.apiKey,
  });

  Future<HttpResult<T>> makeGet<T extends BaseHttpResponse>(
    String path, {
    required T Function(http.Response) convertBodyFunc,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    bool hasApiKey = false,
  });

  Future<HttpResult<T>> makePost<T extends BaseHttpResponse>(
    String path, {
    required T Function(http.Response) convertBodyFunc,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? body,
    bool hasApiKey = false,
  });
}
