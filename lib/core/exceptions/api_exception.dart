/// API 관련 예외 클래스
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  const ApiException({
    required this.message,
    this.statusCode,
    this.responseBody,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return 'ApiException: $message (Status: $statusCode)';
    }
    return 'ApiException: $message';
  }
}

/// 네트워크 연결 예외
class NetworkException extends ApiException {
  const NetworkException({required String message}) : super(message: message);
}

/// 서버 오류 예외
class ServerException extends ApiException {
  const ServerException({
    required String message,
    required int statusCode,
    String? responseBody,
  }) : super(
         message: message,
         statusCode: statusCode,
         responseBody: responseBody,
       );
}
