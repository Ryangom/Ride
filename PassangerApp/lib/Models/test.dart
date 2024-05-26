class TestModel {
  String? name;
  Address? address;

  TestModel({this.name, this.address});

  TestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    return data;
  }
}

class Address {
  String? city;

  Address({this.city});

  Address.fromJson(Map<String, dynamic> json) {
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    return data;
  }
}
