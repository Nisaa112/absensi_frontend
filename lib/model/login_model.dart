class loginModel {
  String? status;
  User? user;
  Authorization? authorization;

  loginModel({this.status, this.user, this.authorization});

  loginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    authorization = json['authorization'] != null
        ? new Authorization.fromJson(json['authorization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.authorization != null) {
      data['authorization'] = this.authorization!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? serialNumber;
  String? role;
  String? deviceId;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Siswa? siswa;

  User(
      {this.id,
      this.name,
      this.serialNumber,
      this.role,
      this.deviceId,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.siswa});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serial_number'];
    role = json['role'];
    deviceId = json['device_id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    siswa = json['siswa'] != null ? new Siswa.fromJson(json['siswa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['serial_number'] = this.serialNumber;
    data['role'] = this.role;
    data['device_id'] = this.deviceId;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.siswa != null) {
      data['siswa'] = this.siswa!.toJson();
    }
    return data;
  }
}

class Siswa {
  int? id;
  int? userId;
  String? nisn;
  String? namaSiswa;
  String? createdAt;
  String? updatedAt;

  Siswa(
      {this.id,
      this.userId,
      this.nisn,
      this.namaSiswa,
      this.createdAt,
      this.updatedAt});

  Siswa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nisn = json['nisn'];
    namaSiswa = json['nama_siswa'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nisn'] = this.nisn;
    data['nama_siswa'] = this.namaSiswa;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Authorization {
  String? token;
  String? type;

  Authorization({this.token, this.type});

  Authorization.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['type'] = this.type;
    return data;
  }
}