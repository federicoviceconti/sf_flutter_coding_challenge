import 'package:http/http.dart';

class ErrorHttpException implements Exception {
  final Response? response;

  ErrorHttpException.fromResponse(this.response);
}
