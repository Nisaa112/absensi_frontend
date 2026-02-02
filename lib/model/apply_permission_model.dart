class applypermissionModel {
  String? status;
  Data? data;

  applypermissionModel({this.status, this.data});

  applypermissionModel.fromJson(Map<String, dynamic> json) {
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
  int? siswaId;
  String? tglIzin;
  String? jenisIzin;
  String? alasan;
  String? buktiGambar;
  String? validatorId;
  String? statusIzin;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.siswaId,
      this.tglIzin,
      this.jenisIzin,
      this.alasan,
      this.buktiGambar,
      this.validatorId,
      this.statusIzin,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    siswaId = json['siswa_id'];
    tglIzin = json['tgl_izin'];
    jenisIzin = json['jenis_izin'];
    alasan = json['alasan'];
    buktiGambar = json['bukti_gambar'];
    validatorId = json['validator_id'];
    statusIzin = json['status_izin'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siswa_id'] = this.siswaId;
    data['tgl_izin'] = this.tglIzin;
    data['jenis_izin'] = this.jenisIzin;
    data['alasan'] = this.alasan;
    data['bukti_gambar'] = this.buktiGambar;
    data['validator_id'] = this.validatorId;
    data['status_izin'] = this.statusIzin;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}