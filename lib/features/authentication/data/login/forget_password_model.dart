import 'package:equatable/equatable.dart';

//ignore: must_be_immutable
class ForgetPasswordModel extends Equatable {
  String? status;
  String? message;

  ForgetPasswordModel({this.status, this.message});

  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
