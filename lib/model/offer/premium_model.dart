class PremiumItem {
  String? name;
  double? premium;
  double? rate;

  PremiumItem({this.name, this.premium, this.rate});

  PremiumItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    premium = json['premium'].toDouble();
    rate = json['rate'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['premium'] = this.premium;
    data['rate'] = this.rate;
    return data;
  }
}