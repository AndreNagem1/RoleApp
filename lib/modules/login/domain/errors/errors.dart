abstract class Failure implements Exception {
  String get message;
}

class ConnectionError extends Failure {
  @override
  final String message;

  ConnectionError({required this.message});
}

class ErrorLoginEmail extends Failure {
  @override
  final String message;

  ErrorLoginEmail({required this.message});
}

class ErrorLoginPhone extends Failure {
  @override
  final String message;

  ErrorLoginPhone({required this.message});
}
