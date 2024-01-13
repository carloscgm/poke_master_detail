class HTTPException implements Exception {
  final int statusCode;
  final String message;

  HTTPException(this.statusCode, this.message);

  @override
  String toString() {
    return message;
  }
}