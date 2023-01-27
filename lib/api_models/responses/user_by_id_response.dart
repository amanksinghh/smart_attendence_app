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
  FullName? fullName;
  Userdetails? userdetails;
  String? role;
  String? userPhoto;
  List<String>? userFaceData;
  String? sId;
  String? email;
  String? orgLongitude;
  String? orgLatitude;
  String? password;
  bool? verified;
  List<MyLeaves>? myLeaves;
  List<Logs>? logs;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? currLat;
  String? currLong;
  String? entry;
  String? exit;

  Users(
      {this.fullName,
      this.userdetails,
      this.role,
      this.userPhoto,
      this.userFaceData,
      this.sId,
      this.email,
      this.orgLongitude,
      this.orgLatitude,
      this.password,
      this.verified,
      this.myLeaves,
      this.logs,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.currLat,
      this.currLong,
      this.entry,
      this.exit});

  Users.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] != null
        ? new FullName.fromJson(json['fullName'])
        : null;
    userdetails = json['userdetails'] != null
        ? new Userdetails.fromJson(json['userdetails'])
        : null;
    role = json['role'];
    userPhoto = json['userPhoto'];
    userFaceData = json['userFaceData'].cast<String>();
    sId = json['_id'];
    email = json['email'];
    orgLongitude = json['orgLongitude'];
    orgLatitude = json['orgLatitude'];
    password = json['password'];
    verified = json['verified'];
    if (json['myLeaves'] != null) {
      myLeaves = <MyLeaves>[];
      json['myLeaves'].forEach((v) {
        myLeaves!.add(new MyLeaves.fromJson(v));
      });
    }
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(new Logs.fromJson(v));
      });
    }
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
    if (this.fullName != null) {
      data['fullName'] = this.fullName!.toJson();
    }
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.toJson();
    }
    data['role'] = this.role;
    data['userPhoto'] = this.userPhoto;
    data['userFaceData'] = this.userFaceData;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['orgLongitude'] = this.orgLongitude;
    data['orgLatitude'] = this.orgLatitude;
    data['password'] = this.password;
    data['verified'] = this.verified;
    if (this.myLeaves != null) {
      data['myLeaves'] = this.myLeaves!.map((v) => v.toJson()).toList();
    }
    if (this.logs != null) {
      data['logs'] = this.logs!.map((v) => v.toJson()).toList();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Userdetails {
  Address? address;
  String? org;
  String? dateOfBirth;
  String? designation;
  int? phone;

  Userdetails(
      {this.address, this.org, this.dateOfBirth, this.designation, this.phone});

  Userdetails.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    org = json['org'];
    dateOfBirth = json['dateOfBirth'];
    designation = json['designation'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['org'] = this.org;
    data['dateOfBirth'] = this.dateOfBirth;
    data['designation'] = this.designation;
    data['phone'] = this.phone;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  int? pin;
  String? country;

  Address({this.street, this.city, this.pin, this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    pin = json['pin'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['pin'] = this.pin;
    data['country'] = this.country;
    return data;
  }
}

class MyLeaves {
  String? leaveType;
  bool? leaveStatus;
  String? sId;
  String? from;
  String? to;
  String? reason;

  MyLeaves(
      {this.leaveType,
      this.leaveStatus,
      this.sId,
      this.from,
      this.to,
      this.reason});

  MyLeaves.fromJson(Map<String, dynamic> json) {
    leaveType = json['leaveType'];
    leaveStatus = json['leaveStatus'];
    sId = json['_id'];
    from = json['from'];
    to = json['to'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveType'] = this.leaveType;
    data['leaveStatus'] = this.leaveStatus;
    data['_id'] = this.sId;
    data['from'] = this.from;
    data['to'] = this.to;
    data['reason'] = this.reason;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date'] = this.date;
    data['workingHours'] = this.workingHours;
    return data;
  }
}
