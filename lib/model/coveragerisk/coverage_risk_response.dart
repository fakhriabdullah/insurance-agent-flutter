import 'package:insurance_agent_flutter/model/coveragerisk/coverage_risk_model.dart';

class CoverageRiskResponse {
  bool? status;
  String? message;
  List<CoverageRiskModel>? data;

  CoverageRiskResponse({this.status, this.message, this.data});

  CoverageRiskResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CoverageRiskModel>[];
      json['data'].forEach((v) {
        data!.add(CoverageRiskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
