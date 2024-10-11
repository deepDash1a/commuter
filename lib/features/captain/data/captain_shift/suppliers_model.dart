import 'package:commuter/core/shared/model/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllSuppliersModel extends BaseResponseModel<List<SuppliersModel>> {
  const GetAllSuppliersModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetAllSuppliersModel.fromJson(Map<String, dynamic> json) {
    return GetAllSuppliersModel(
      status: json['status'],
      message: json['message'],
      body: List<SuppliersModel>.from(
          json['suppliers'].map((e) => SuppliersModel.fromJson(e))).toList(),
    );
  }
}

class SuppliersModel extends Equatable {
  final int id;
  final int shiftId;
  final String supplierName;
  final String price;
  final String wayPay;
  final String imageUploadSupplier;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SuppliersModel({
    required this.id,
    required this.shiftId,
    required this.supplierName,
    required this.price,
    required this.wayPay,
    required this.imageUploadSupplier,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for creating a new Supplier instance from a JSON map
  factory SuppliersModel.fromJson(Map<String, dynamic> json) {
    return SuppliersModel(
      id: json['id'],
      shiftId: json['shift_id'],
      supplierName: json['supplier_name'],
      price: json['price'],
      wayPay: json['way_pay'],
      imageUploadSupplier: json['image_upload_supplier'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shift_id': shiftId,
      'supplier_name': supplierName,
      'price': price,
      'way_pay': wayPay,
      'image_upload_supplier': imageUploadSupplier.toString(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        shiftId,
        supplierName,
        price,
        wayPay,
        imageUploadSupplier,
        createdAt,
        updatedAt,
      ];
}
