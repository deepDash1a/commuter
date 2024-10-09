import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class DashBoardMessageModel extends Equatable {
  String? status;
  List<Messages>? messages;

  DashBoardMessageModel({this.status, this.messages});

  DashBoardMessageModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        messages,
      ];
}

// ignore: must_be_immutable
class Messages extends Equatable {
  int? id;
  int? userId;
  String? content;
  String? date;
  String? status;
  String? senderName;
  String? createdAt;
  String? updatedAt;

  Messages(
      {this.id,
      this.userId,
      this.content,
      this.date,
      this.status,
      this.senderName,
      this.createdAt,
      this.updatedAt});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    content = json['content'];
    date = json['date'];
    status = json['status'];
    senderName = json['sender_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['content'] = content;
    data['date'] = date;
    data['status'] = status;
    data['sender_name'] = senderName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        date,
        status,
        senderName,
        createdAt,
        updatedAt,
      ];
}
