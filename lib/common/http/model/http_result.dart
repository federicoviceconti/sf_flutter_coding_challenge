import 'base_http_response.dart';
import 'error_http_response.dart';

class HttpResult<T extends BaseHttpResponse> {
  final T? result;
  final ErrorHttpResponse? error;

  bool get hasError => error != null;

  HttpResult({
    this.result,
    this.error,
  });
}