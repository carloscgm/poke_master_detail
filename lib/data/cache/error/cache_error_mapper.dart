class CacheErrorMapper {
  CacheErrorMapper();

  static Exception getException(dynamic error) {
    return error is Exception ? error : Exception(error.toString());
  }
}
