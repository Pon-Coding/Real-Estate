import 'dart:io';

class HttpResponseException implements Exception {
  final String _message;
  final String _prefix;

  HttpResponseException(this._prefix, this._message);

  String toStringInfo() {
    return "$_prefix$_message";
  }
}

class BadRequestException extends HttpResponseException {
  BadRequestException(String message) : super(message, "Bad Request:");
}

class UnauthorizedException extends HttpResponseException {
  UnauthorizedException(String message) : super(message, "Unauthorized:");
}

class ForbiddenException extends HttpResponseException {
  ForbiddenException(String message) : super(message, "Forbidden:");
}

class NotFoundException extends HttpResponseException {
  NotFoundException(String message) : super(message, "NotFound:");
}

class InternalServerException extends HttpResponseException {
  InternalServerException(String message)
      : super(message, "Internal Server Error:");
}

class FetchDataException extends HttpResponseException {
  FetchDataException(String message) : super(message, "Fetch Data Problem:");
}

void throwHttpResponseException(int statusCode, String exceptionMessage) {
  switch (statusCode) {
    case HttpStatus.badRequest:
      throw BadRequestException(exceptionMessage);
    case HttpStatus.unauthorized:
      throw UnauthorizedException(exceptionMessage);
    case HttpStatus.forbidden:
      throw ForbiddenException(exceptionMessage);
    case HttpStatus.notFound:
      throw NotFoundException(exceptionMessage);
    case HttpStatus.internalServerError:
      throw InternalServerException(exceptionMessage);
    default:
      throw FetchDataException("Some went wrong with StatusCode: $statusCode");
  }
}
