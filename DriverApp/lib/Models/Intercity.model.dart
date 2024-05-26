import 'package:ride_Driver/Models/Bided.model.dart';
import 'package:ride_Driver/Models/User.model.dart';

class CarRent {
  PickupLocationGeoCode? pickupLocationGeoCode;
  DestinationGeoCode? destinationGeoCode;
  String? sId;
  String? pickupLocationEn;
  String? destinationEn;
  String? scheduledTime;
  User? customer;
  String? driver;
  String? distance;
  String? eta;
  List<Bided>? bided;
  String? createdAt;
  String? totalPrice;
  String? status;
  int? iV;

  CarRent(
      {this.pickupLocationGeoCode,
      this.destinationGeoCode,
      this.sId,
      this.pickupLocationEn,
      this.destinationEn,
      this.scheduledTime,
      this.customer,
      this.driver,
      this.distance,
      this.eta,
      this.bided,
      this.createdAt,
      this.totalPrice,
      this.status,
      this.iV});

  CarRent.fromJson(Map<String, dynamic> json) {
    pickupLocationGeoCode = json['pickupLocationGeoCode'] != null
        ? new PickupLocationGeoCode.fromJson(json['pickupLocationGeoCode'])
        : null;
    destinationGeoCode = json['destinationGeoCode'] != null
        ? new DestinationGeoCode.fromJson(json['destinationGeoCode'])
        : null;
    sId = json['_id'];
    pickupLocationEn = json['pickupLocationEn'];
    destinationEn = json['destinationEn'];
    scheduledTime = json['scheduledTime'];
    customer = json['customer'] != null ? new User.fromJson(json['customer']) : null;
    driver = json['driver'];
    distance = json['distance'];
    eta = json['eta'];
    bided = json['bided'] != null
        ? (json['bided'] as List).map((i) => Bided.fromJson(i)).toList()
        : null;
    status = json['status'];
    totalPrice = json['totalPrice'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pickupLocationGeoCode != null) {
      data['pickupLocationGeoCode'] = this.pickupLocationGeoCode!.toJson();
    }
    if (this.destinationGeoCode != null) {
      data['destinationGeoCode'] = this.destinationGeoCode!.toJson();
    }
    data['_id'] = this.sId;
    data['pickupLocationEn'] = this.pickupLocationEn;
    data['destinationEn'] = this.destinationEn;
    data['scheduledTime'] = this.scheduledTime;
    data['customer'] = this.customer!.toJson();
    data['driver'] = this.driver;
    data['bided'] = this.bided;
    data['distance'] = this.distance;
    data['eta'] = this.eta;
    data['createdAt'] = this.createdAt;
    data['totalPrice'] = this.totalPrice;

    data['status'] = this.status;
    data['__v'] = this.iV;
    return data;
  }
}

class PickupLocationGeoCode {
  String? type;
  List<double>? coordinates;

  PickupLocationGeoCode({this.type, this.coordinates});

  PickupLocationGeoCode.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class DestinationGeoCode {
  String? type;
  List<double>? coordinates;

  DestinationGeoCode({this.type, this.coordinates});

  DestinationGeoCode.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
