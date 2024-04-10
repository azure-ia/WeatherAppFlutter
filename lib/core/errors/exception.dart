class APIException implements Exception {
  final String message;
  final int statusCode;

  APIException(this.statusCode, this.message);

  @override
  String toString() {
    return message;
  }
}

class CacheException implements Exception {
  final String message;
  final int statusCode;

  CacheException(this.statusCode, this.message);

  @override
  String toString() {
    return message;
  }
}

class StorageException implements Exception {
  final String message;
  final int statusCode;

  StorageException(this.statusCode, this.message);

  @override
  String toString() {
    return message;
  }
}
