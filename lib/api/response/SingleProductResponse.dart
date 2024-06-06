import 'package:shop/model/Products.dart';

class SingleProductResponse {
  bool? success;
  Products? data;
  String? message;

  SingleProductResponse({this.success, this.data, this.message});

  SingleProductResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Products.fromJson2(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}