class attendancesessionModel {
  String? status;
  String? tokenQr;

  attendancesessionModel({this.status, this.tokenQr});

  attendancesessionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    tokenQr = json['token_qr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token_qr'] = this.tokenQr;
    return data;
  }
}