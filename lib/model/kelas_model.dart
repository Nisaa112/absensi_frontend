class kelasModel {
  int? id;
  String? namaKelas;
  int? tahunAjaranId;
  int? waliKelasId;
  String? createdAt;
  String? updatedAt;
  TahunAjaran? tahunAjaran;
  Wali? wali;

  kelasModel(
      {this.id,
      this.namaKelas,
      this.tahunAjaranId,
      this.waliKelasId,
      this.createdAt,
      this.updatedAt,
      this.tahunAjaran,
      this.wali});

  kelasModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKelas = json['nama_kelas'];
    tahunAjaranId = json['tahun_ajaran_id'];
    waliKelasId = json['wali_kelas_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    tahunAjaran = json['tahun_ajaran'] != null
        ? new TahunAjaran.fromJson(json['tahun_ajaran'])
        : null;
    wali = json['wali'] != null ? new Wali.fromJson(json['wali']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kelas'] = this.namaKelas;
    data['tahun_ajaran_id'] = this.tahunAjaranId;
    data['wali_kelas_id'] = this.waliKelasId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.tahunAjaran != null) {
      data['tahun_ajaran'] = this.tahunAjaran!.toJson();
    }
    if (this.wali != null) {
      data['wali'] = this.wali!.toJson();
    }
    return data;
  }
}

class TahunAjaran {
  int? id;
  String? tahun;
  String? semester;
  int? status;
  String? createdAt;
  String? updatedAt;

  TahunAjaran(
      {this.id,
      this.tahun,
      this.semester,
      this.status,
      this.createdAt,
      this.updatedAt});

  TahunAjaran.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tahun = json['tahun'];
    semester = json['semester'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tahun'] = this.tahun;
    data['semester'] = this.semester;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Wali {
  int? id;
  int? userId;
  String? nip;
  String? namaGuru;
  String? createdAt;
  String? updatedAt;

  Wali(
      {this.id,
      this.userId,
      this.nip,
      this.namaGuru,
      this.createdAt,
      this.updatedAt});

  Wali.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    nip = json['nip'];
    namaGuru = json['nama_guru'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['nip'] = this.nip;
    data['nama_guru'] = this.namaGuru;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}