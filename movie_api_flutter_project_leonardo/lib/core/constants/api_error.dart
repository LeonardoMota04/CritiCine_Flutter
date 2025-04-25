enum ApiErrorType {
  network,
  server,
  unauthorized,
  notFound,
  unknown,
}

class ApiError implements Exception {
  final ApiErrorType type;
  final String message;

  ApiError({required this.type, required this.message});

  @override
  String toString() {
    return "ApiError: $type - $message";
  }
}
