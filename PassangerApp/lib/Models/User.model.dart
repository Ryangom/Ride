class User {
  String? name;
  String? email;
  String? image;
  String? password;
  String? mobileNumber;
  String? role;

  User({
    this.name,
    this.email,
    this.image,
    this.password,
    this.mobileNumber,
    this.role,
  });

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    mobileNumber = json['mobileNumber'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['image'] = this.image;
    data['password'] = this.password;
    data['mobileNumber'] = this.mobileNumber;
    data['role'] = this.role;
    return data;
  }
}
