class attendancescanModel {
  String? status;
  String? message;
  int? jarakMeter;

  attendancescanModel({this.status, this.message, this.jarakMeter});

  attendancescanModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jarakMeter = json['jarak_meter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['jarak_meter'] = this.jarakMeter;
    return data;
  }
}