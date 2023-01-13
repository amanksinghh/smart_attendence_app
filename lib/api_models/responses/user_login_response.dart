class UserLoginResponse {
  String? status;
  String? message;
  String? token;
  List<User>? user;

  UserLoginResponse({this.status, this.message, this.token, this.user});

  UserLoginResponse.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  FullName? fullName;
  Userdetails? userdetails;
  String? role;
  String? userPhoto;
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

  User(
      {this.fullName,
        this.userdetails,
        this.role,
        this.userPhoto,
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

  User.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'] != null
        ? FullName.fromJson(json['fullName'])
        : null;
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
    role = json['role'];
    userPhoto = json['userPhoto'];
    sId = json['_id'];
    email = json['email'];
    orgLongitude = json['orgLongitude'];
    orgLatitude = json['orgLatitude'];
    password = json['password'];
    verified = json['verified'];
    if (json['myLeaves'] != null) {
      myLeaves = <MyLeaves>[];
      json['myLeaves'].forEach((v) {
        myLeaves!.add(MyLeaves.fromJson(v));
      });
    }
    if (json['logs'] != null) {
      logs = <Logs>[];
      json['logs'].forEach((v) {
        logs!.add(Logs.fromJson(v));
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
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fullName != null) {
      data['fullName'] = fullName!.toJson();
    }
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    data['role'] = role;
    data['userPhoto'] = userPhoto;
    data['_id'] = sId;
    data['email'] = email;
    data['orgLongitude'] = orgLongitude;
    data['orgLatitude'] = orgLatitude;
    data['password'] = password;
    data['verified'] = verified;
    if (myLeaves != null) {
      data['myLeaves'] = myLeaves!.map((v) => v.toJson()).toList();
    }
    if (logs != null) {
      data['logs'] = logs!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['currLat'] = currLat;
    data['currLong'] = currLong;
    data['entry'] = entry;
    data['exit'] = exit;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['middleName'] = middleName;
    data['lastName'] = lastName;
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
    json['address'] != null ? Address.fromJson(json['address']) : null;
    org = json['org'];
    dateOfBirth = json['dateOfBirth'];
    designation = json['designation'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['org'] = org;
    data['dateOfBirth'] = dateOfBirth;
    data['designation'] = designation;
    data['phone'] = phone;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['street'] = street;
    data['city'] = city;
    data['pin'] = pin;
    data['country'] = country;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leaveType'] = leaveType;
    data['leaveStatus'] = leaveStatus;
    data['_id'] = sId;
    data['from'] = from;
    data['to'] = to;
    data['reason'] = reason;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['date'] = date;
    data['workingHours'] = workingHours;
    return data;
  }
}