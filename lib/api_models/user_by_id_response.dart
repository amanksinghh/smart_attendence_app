class UserByIdResponse {
  Users? users;

  UserByIdResponse({this.users});

  UserByIdResponse.fromJson(Map<String, dynamic> json) {
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
  String? sId;
  String? fullName;
  String? email;
  int? phone;
  String? dateOfBirth;
  String? orgLongitude;
  String? orgLatitude;
  String? org;
  String? designation;
  String? password;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? currLat;
  String? currLong;
  String? entry;
  String? exit;

  Users(
      {this.sId,
        this.fullName,
        this.email,
        this.phone,
        this.dateOfBirth,
        this.orgLongitude,
        this.orgLatitude,
        this.org,
        this.designation,
        this.password,
        this.verified,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.currLat,
        this.currLong,
        this.entry,
        this.exit});

  Users.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    dateOfBirth = json['dateOfBirth'];
    orgLongitude = json['orgLongitude'];
    orgLatitude = json['orgLatitude'];
    org = json['org'];
    designation = json['designation'];
    password = json['password'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    currLat = json['currLat'];
    currLong = json['currLong'];
    entry = json['entry'];
    exit = json['exit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dateOfBirth'] = this.dateOfBirth;
    data['orgLongitude'] = this.orgLongitude;
    data['orgLatitude'] = this.orgLatitude;
    data['org'] = this.org;
    data['designation'] = this.designation;
    data['password'] = this.password;
    data['verified'] = this.verified;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['currLat'] = this.currLat;
    data['currLong'] = this.currLong;
    data['entry'] = this.entry;
    data['exit'] = this.exit;
    return data;
  }
}