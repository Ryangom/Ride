class Bided {
  String? sId;
  String? driver;
  String? rentId;
  int? offeredPrice;
  String? createdAt;
  int? iV;

  Bided({this.sId, this.driver, this.rentId, this.offeredPrice, this.createdAt, this.iV});

  Bided.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    driver = json['driver'];
    rentId = json['rentId'];
    offeredPrice = json['offeredPrice'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['driver'] = this.driver;
    data['rentId'] = this.rentId;
    data['offeredPrice'] = this.offeredPrice;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
