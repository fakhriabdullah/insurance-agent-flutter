import 'package:insurance_agent_flutter/model/offer/premium_model.dart';

class OfferDetail {
  String? startDate;
  String? endDate;
  double? totalPremium;
  List<PremiumItem>? premiumItem;

  OfferDetail({this.startDate, this.endDate, this.totalPremium, this.premiumItem});

  OfferDetail.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    totalPremium = json['total_premium'].toDouble();
    if (json['premium_item'] != null) {
      premiumItem = <PremiumItem>[];
      json['premium_item'].forEach((v) {
        premiumItem!.add(new PremiumItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['total_premium'] = this.totalPremium;
    if (this.premiumItem != null) {
      data['premium_item'] = this.premiumItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
