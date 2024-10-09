import 'package:commuter/core/network/api/api_consumer.dart';
import 'package:commuter/core/network/api/end_points.dart';
import 'package:commuter/core/network/error/exceptions.dart';
import 'package:commuter/core/shared/logic/shared_pref.dart';
import 'package:commuter/core/shared/logic/shared_pref_keys.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.options.headers['Authorization'] =
        SharedPrefService.getData(key: SharedPrefKeys.token) != null
            ? 'Bearer ${SharedPrefService.getData(key: SharedPrefKeys.token)}'
            : null;
    dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  @override
  Future<Response> delete(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (error) {
      handelDioException(error);
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> get(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.get(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (error) {
      handelDioException(error);
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (error) {
      handelDioException(error);
      throw UnimplementedError();
    }
  }

  @override
  Future<Response> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      bool isFormData = false,
      Options? options}) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (error) {
      handelDioException(error);
      throw UnimplementedError();
    }
  }
}
