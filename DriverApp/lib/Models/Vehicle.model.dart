import 'package:ride_Driver/Models/User.model.dart';

class Vehicle {
  String? name;
  String? plateNumber;
  String? color;
  String? image;
  User? vehicleOwner;

  Vehicle({this.name, this.plateNumber, this.color, this.image, this.vehicleOwner});

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    plateNumber = json['plateNumber'];
    color = json['color'];
    image = json['image'];
    vehicleOwner = json['vehicleOwner'] == '' ? new User.fromJson(json['vehicleOwner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['plateNumber'] = this.plateNumber;
    data['color'] = this.color;
    data['image'] = this.image;
    data['vehicleOwner'] = this.vehicleOwner;
    return data;
  }
}
