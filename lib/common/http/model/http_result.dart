import 'base_http_response.dart';
import 'error_http_response.dart';

class HttpResult<T extends BaseHttpResponse> {
  final int? statusCode;
  final T? result;

  bool get hasError => statusCode == null || statusCode != 200;

  HttpResult({
    this.result,
    this.statusCode,
  });
}