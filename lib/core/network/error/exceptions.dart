import 'package:commuter/core/network/error/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handelDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.sendTimeout:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: ErrorModel.fromJson(
          error.response!.data,
        ),
      );
    case DioExceptionType.badResponse:
      switch (error.response!.statusCode) {
        case 300: // bad response
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 301: // bad response
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 302: // bad response
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 400: // bad response
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 401: // unauthorized
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 403: // forbidden
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 404: // not found
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 409: // coefficient
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 422: // unprocessable entity
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 500: // unprocessable entity
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
        case 504: // server exception
          throw ServerException(
            errorModel: ErrorModel.fromJson(
              error.response!.data,
            ),
          );
      }
  }
}
