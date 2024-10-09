import 'package:commuter/core/shared/model/base_response_model.dart';

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
      body: List<SuppliersModel>.from(json['suppliers']
          .map((e) => SuppliersModel.fromJson(e))).toList(),
    );
  }

}

class SuppliersModel {
  int? id;
  int? shiftId;
  String? supplierName;
  String? price;
  String? wayPay;
  String? confirm;
  String? createdAt;
  String? updatedAt;

  SuppliersModel(
      {this.id,
        this.shiftId,
        this.supplierName,
        this.price,
        this.wayPay,
        this.confirm,
        this.createdAt,
        this.updatedAt});

  SuppliersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shiftId = json['shift_id'];
    supplierName = json['supplier_name'];
    price = json['price'];
    wayPay = json['way_pay'];
    confirm = json['confirm'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shift_id'] = shiftId;
    data['supplier_name'] = supplierName;
    data['price'] = price;
    data['way_pay'] = wayPay;
    data['confirm'] = confirm;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
