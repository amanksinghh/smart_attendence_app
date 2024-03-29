class UserPutLocationResponse {
  bool? status;
  Data? data;

  UserPutLocationResponse({this.status, this.data});

  UserPutLocationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FullName? fullName;
  String? role;
  String? sId;
  String? email;
  String? orgLongitude;
  String? orgLatitude;
  List<Userdetails>? userdetails;
  String? password;
  bool? verified;
  List<Null>? myLeaves;
  List<Logs>? logs;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? userPhoto;
  Null? currLat;
  Null? currLong;
  Null? entry;
  String? exit;

  Data(
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
        this.userPhoto,
        this.currLat,
        this.currLong,
        this.entry,
        this.exit});

  Data.fromJson(Map<String, dynamic> json) {
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
    //     myLeaves!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(Logs.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userPhoto = json['userPhoto'];
    currLat = json['currLat'];
    currLong = json['currLong'];
    entry = json['entry'];
    exit = json['exit'];
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
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['userPhoto'] = this.userPhoto;
    data['currLat'] = this.currLat;
    data['currLong'] = this.currLong;
    data['entry'] = this.entry;
    data['exit'] = this.exit;
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

class Logs {
  String? sId;
  String? date;
  int? workingHours;

  Logs({this.sId, this.date, this.workingHours});

  Logs.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    date = json['date'];
    workingHours = json['workingHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['workingHours'] = this.workingHours;
    return data;
  }
}