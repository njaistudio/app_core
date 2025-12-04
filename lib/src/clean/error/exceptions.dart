class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  ServerException({this.message, this.statusCode});
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);
}