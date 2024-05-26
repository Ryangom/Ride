import 'package:ride_Driver/Models/Vehicle.model.dart';

class User {
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? image;
  String? password;
  String? mobileNumber;
  Vehicle? vehicle;
  String? role;
  String? status;
  String? createdAt;

  User(
      {this.location,
      this.sId,
      this.name,
      this.email,
      this.image,
      this.password,
      this.mobileNumber,
      this.vehicle,
      this.role,
      this.status,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    mobileNumber = json['mobileNumber'];
    vehicle = json['vehicle'] == '' ? new Vehicle.fromJson(json['vehicle']) : null;
    role = json['role'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    // data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['mobileNumber'] = this.mobileNumber;
    data['vehicle'] = this.vehicle;
    data['role'] = this.role;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
