class LoginResponse {
  String? status;
  String? message;
  String? token;
  List<User>? user;

  LoginResponse({this.status, this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  FullName? fullName;
  String? role;
  String? sId;
  String? email;
  String? orgLongitude;
  String? orgLatitude;
  List<Userdetails>? userdetails;
  String? password;
  bool? verified;
  List<void>? myLeaves;
  List<void>? logs;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? userPhoto;

  User(
      {this.fullName,
        this.role,
        this.sId,
        this.email,
        this.orgLongitude,
        this.orgLatitude,
        this.userdetails,
        this.password,
        this.verified,
        this.myLeaves,
        this.logs,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.userPhoto});

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] != null
        ? FullName.fromJson(json['fullName'])
        : null;
    role = json['role'];
    sId = json['_id'];
    email = json['email'];
    orgLongitude = json['orgLongitude'];
    orgLatitude = json['orgLatitude'];
    if (json['userdetails'] != null) {
      userdetails = <Userdetails>[];
      json['userdetails'].forEach((v) {
        userdetails!.add(Userdetails.fromJson(v));
      });
    }
    password = json['password'];
    verified = json['verified'];
    // if (json['myLeaves'] != null) {
    //   myLeaves = <Null>[];
    //   json['myLeaves'].forEach((v) {
    //     myLeaves!.add(Null.fromJson(v));
    //   });
    // }
    // if (json['logs'] != null) {
    //   logs = <Null>[];
    //   json['logs'].forEach((v) {
    //     logs!.add(Null.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userPhoto = json['userPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.fullName != null) {
      data['fullName'] = this.fullName!.toJson();
    }
    data['role'] = this.role;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['orgLongitude'] = this.orgLongitude;
    data['orgLatitude'] = this.orgLatitude;
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.map((v) => v.toJson()).toList();
    }
    data['password'] = this.password;
    data['verified'] = this.verified;
    // if (this.myLeaves != null) {
    //   data['myLeaves'] = this.myLeaves!.map((v) => v.toJson()).toList();
    // }
    // if (this.logs != null) {
    //   data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['userPhoto'] = this.userPhoto;
    return data;
  }
}

class FullName {
  String? firstName;
  String? middleName;
  String? lastName;

  FullName({this.firstName, this.middleName, this.lastName});

  FullName.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Userdetails {
  List<int>? phone;
  String? sId;
  String? org;
  String? dateOfBirth;
  String? designation;

  Userdetails(
      {this.phone, this.sId, this.org, this.dateOfBirth, this.designation});

  Userdetails.fromJson(Map<String, dynamic> json) {
    phone = json['phone'].cast<int>();
    sId = json['_id'];
    org = json['org'];
    dateOfBirth = json['dateOfBirth'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone'] = this.phone;
    data['_id'] = this.sId;
    data['org'] = this.org;
    data['dateOfBirth'] = this.dateOfBirth;
    data['designation'] = this.designation;
    return data;
  }
}