class userModel {
  bool? status;
  Data? data;

  userModel({this.status, this.data});

  userModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name; 
  String? serialNumber;
  String? role;
  String? deviceId; 
  String? email; 
  String? emailVerifiedAt; 
  String? createdAt;
  String? updatedAt;

  Data({
    this.id,
    this.name,
    this.serialNumber,
    this.role,
    this.deviceId,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serialNumber = json['serial_number'];
    role = json['role'];
    deviceId = json['device_id'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['serial_number'] = serialNumber;
    data['role'] = role;
    data['device_id'] = deviceId;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}