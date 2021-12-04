import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:sf_flutter_coding_challenge/common/config/app_config.dart';
import 'package:sf_flutter_coding_challenge/common/http/client/base_coin_client.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/base_http_response.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/error_http_response.dart';
import 'package:sf_flutter_coding_challenge/common/http/model/http_result.dart';
import 'package:http/http.dart' as http;

class CoinCapClient extends BaseCoinClient {
  final String headerAuthorization = 'Authorization';
  final String getMethod = 'GET';
  final String postMethod = 'POST';

  CoinCapClient(AppConfig config)
      : super(
          basePath: config.baseUrlCoinCap,
          apiKey: config.apiKey,
        );

  @override
  Future<HttpResult<T>> makeGet<T extends BaseHttpResponse>(
    String path, {
    required T Function(Response response) convertBodyFunc,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    bool hasApiKey = false,
  }) {
    return _makeRequest(
      method: getMethod,
      path: path,
      convertFunc: convertBodyFunc,
      headers: headers,
      queryParameters: queryParameters,
      hasApiKey: hasApiKey,
    );
  }

  @override
  Future<HttpResult<T>> makePost<T extends BaseHttpResponse>(
    String path, {
    required T Function(http.Response p1) convertBodyFunc,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? body,
    bool hasApiKey = false,
  }) {
    return _makeRequest(
      method: postMethod,
      path: path,
      convertFunc: convertBodyFunc,
      headers: headers,
      queryParameters: queryParameters,
      body: body,
      hasApiKey: hasApiKey,
    );
  }

  Future<HttpResult<T>> _makeRequest<T extends BaseHttpResponse>({
    required String method,
    required String path,
    required T Function(http.Response) convertFunc,
    required bool hasApiKey,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      if (hasApiKey) {
        headers ??= {};
        headers[headerAuthorization] = 'Bearer $apiKey';
      }

      final response = await _makeRequestByMethod(
        path: path,
        method: method,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
      );

      return HttpResult(
        result: convertFunc(response),
      );
    } on Exception catch (e) {
      _logException(e, method: method, path: path);
      return Future.value(
        HttpResult<T>(
          error: ErrorHttpResponse(),
        ),
      );
    }
  }

  Future<http.Response> _makeRequestByMethod({
    required String path,
    required String method,
    Map<String, String>? headers,
    Map<String, String?>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    queryParameters
        ?.removeWhere((key, value) => value == null || value.isEmpty);

    final uri =
        Uri.parse(basePath + path).replace(queryParameters: queryParameters);

    Response? response;

    switch (method) {
      case 'GET':
        response = await http.get(
          uri,
          headers: headers,
        );
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: body,
        );
        break;
      default:
        throw UnsupportedError(
            '$method not supported for the client -> $CoinCapClient!');
    }

    _logResponse(method, uri, headers, body, response);

    return response;
  }

  void _logResponse(
    String method,
    Uri uri,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    http.Response response,
  ) {
    debugPrint("\n|==REQUEST");
    debugPrint("|__$method $uri");
    debugPrint("|__headers: $headers");

    if (body != null) {
      debugPrint("|__Body: $body");
    }

    debugPrint("|==RESPONSE");
    debugPrint("|__Code: ${response.statusCode}");
    debugPrint("|__Body: ${response.body}\n");
  }

  void _logException(Exception e, {String? method, String? path}) {
    debugPrint("\n|==EXCEPTION\n|__$method: $path\n|__Exception:$e\n");
  }
}
