import 'package:insurance_agent_flutter/model/offer/offer_model.dart';

class OfferDetailResponse {
  bool? status;
  String? message;
  OfferModel? data;

  OfferDetailResponse({this.status, this.message, this.data});

  OfferDetailResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new OfferModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}