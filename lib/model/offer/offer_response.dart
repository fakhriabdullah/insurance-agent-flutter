import 'package:insurance_agent_flutter/model/offer/offer_model.dart';

class OfferResponse {
  bool? status;
  String? message;
  List<OfferModel>? data;
  int? totalPage;

  OfferResponse({this.status, this.message, this.data, this.totalPage});

  OfferResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalPage = json['total_page'];
    if (json['data'] != null) {
      data = <OfferModel>[];
      json['data'].forEach((v) {
        data!.add(new OfferModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_page'] = this.totalPage;

    return data;
  }
}
