class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

class BadRequestException extends HttpException {
  BadRequestException(super.message)
      : super(statusCode: 400);
}

class UnauthorizedException extends HttpException {
  UnauthorizedException(super.message)
      : super(statusCode: 401);
}

class ForbiddenException extends HttpException {
  ForbiddenException(super.message)
      : super(statusCode: 403);
}

class NotFoundException extends HttpException {
  NotFoundException(super.message)
      : super(statusCode: 404);
}

class ServiceUnavailableException extends HttpException {
  ServiceUnavailableException(super.message)
      : super(statusCode: 503);
}

class ServerException extends HttpException {
  ServerException(super.message, {super.statusCode});
}
