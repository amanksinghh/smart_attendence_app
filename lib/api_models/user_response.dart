class UsersResponseModel {
  List<Users>? users;

  UsersResponseModel({this.users});

  UsersResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? sId;
  String? fullName;
  String? email;
  int? phone;
  String? password;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? entry;
  String? exit;
  String? latitude;
  String? longitude;

  Users(
      {this.sId,
      this.fullName,
      this.email,
      this.phone,
      this.password,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.entry,
      this.exit,
      this.latitude,
      this.longitude});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    entry = json['entry'];
    exit = json['exit'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['verified'] = this.verified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['entry'] = this.entry;
    data['exit'] = this.exit;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
