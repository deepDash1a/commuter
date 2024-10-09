import 'package:equatable/equatable.dart';

class BaseResponseModel<T> extends Equatable {
  final String? status;
  final String? message;
  final String? token;
  final T? body;

  const BaseResponseModel({
    required this.status,
    required this.message,
    this.token,
    this.body,
  });

  factory BaseResponseModel.fromJson(Map<String, dynamic> json) {
    return BaseResponseModel(
      status: json['status'],
      message: json['message'],
      token: json['token'],
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        token,
        T,
      ];
}
