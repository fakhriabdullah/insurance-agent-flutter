import 'package:insurance_agent_flutter/model/offer/offer_detail.dart';

class OfferModel {
  int? id;
  String? userId;
  String? name;
  String? startDate;
  String? endDate;
  String? coverageName;
  double? coveragePrice;
  int? coverageType;
  double? rate;
  double? premium;
  String? createdAt;
  String? updatedAt;
  String? coverageRisk;
  List<OfferDetail>? detail;

  OfferModel(
      {this.id,
      this.userId,
      this.name,
      this.startDate,
      this.endDate,
      this.coverageName,
      this.coveragePrice,
      this.coverageType,
      this.rate,
      this.premium,
      this.createdAt,
      this.updatedAt,
      this.coverageRisk,
      this.detail});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    coverageName = json['coverage_name'];
    coveragePrice = json['coverage_price'].toDouble();
    coverageType = json['coverage_type'];
    rate = json['rate'].toDouble();
    premium = json['premium'].toDouble();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    coverageRisk = json['coverage_risk'];
    if (json['detail'] != null) {
      detail = <OfferDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new OfferDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['coverage_name'] = this.coverageName;
    data['coverage_price'] = this.coveragePrice;
    data['coverage_type'] = this.coverageType;
    data['rate'] = this.rate;
    data['premium'] = this.premium;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['coverage_risk'] = this.coverageRisk;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}