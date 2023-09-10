class CoverageRiskModel {
  String? id;
  String? name;
  double? rateComprehensive;
  double? rateTotalLossOnly;

  CoverageRiskModel({
    this.id,
    this.name,
    this.rateComprehensive,
    this.rateTotalLossOnly,
  });

  CoverageRiskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rateComprehensive = json['rate_comprehensive'].toDouble();
    rateTotalLossOnly = json['rate_total_loss_only'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rate_comprehensive'] = rateComprehensive;
    data['rate_total_loss_only'] = rateTotalLossOnly;
    return data;
  }
}
