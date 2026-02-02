class academicModel {
  TahunAktif? tahunAktif;
  List<DaftarKelas>? daftarKelas;
  List<DaftarMapel>? daftarMapel;

  academicModel({this.tahunAktif, this.daftarKelas, this.daftarMapel});

  academicModel.fromJson(Map<String, dynamic> json) {
    tahunAktif = json['tahun_aktif'] != null
        ? new TahunAktif.fromJson(json['tahun_aktif'])
        : null;
    if (json['daftar_kelas'] != null) {
      daftarKelas = <DaftarKelas>[];
      json['daftar_kelas'].forEach((v) {
        daftarKelas!.add(new DaftarKelas.fromJson(v));
      });
    }
    if (json['daftar_mapel'] != null) {
      daftarMapel = <DaftarMapel>[];
      json['daftar_mapel'].forEach((v) {
        daftarMapel!.add(new DaftarMapel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tahunAktif != null) {
      data['tahun_aktif'] = this.tahunAktif!.toJson();
    }
    if (this.daftarKelas != null) {
      data['daftar_kelas'] = this.daftarKelas!.map((v) => v.toJson()).toList();
    }
    if (this.daftarMapel != null) {
      data['daftar_mapel'] = this.daftarMapel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TahunAktif {
  int? id;
  String? tahun;
  String? semester;
  int? status;
  String? createdAt;
  Null? updatedAt;

  TahunAktif(
      {this.id,
      this.tahun,
      this.semester,
      this.status,
      this.createdAt,
      this.updatedAt});

  TahunAktif.fromJson(Map<String, dynamic> json) {
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

class DaftarKelas {
  int? id;
  String? namaKelas;
  int? tahunAjaranId;
  int? waliKelasId;
  String? createdAt;
  Null? updatedAt;
  WaliKelas? waliKelas;

  DaftarKelas(
      {this.id,
      this.namaKelas,
      this.tahunAjaranId,
      this.waliKelasId,
      this.createdAt,
      this.updatedAt,
      this.waliKelas});

  DaftarKelas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKelas = json['nama_kelas'];
    tahunAjaranId = json['tahun_ajaran_id'];
    waliKelasId = json['wali_kelas_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    waliKelas = json['wali_kelas'] != null
        ? new WaliKelas.fromJson(json['wali_kelas'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kelas'] = this.namaKelas;
    data['tahun_ajaran_id'] = this.tahunAjaranId;
    data['wali_kelas_id'] = this.waliKelasId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.waliKelas != null) {
      data['wali_kelas'] = this.waliKelas!.toJson();
    }
    return data;
  }
}

class WaliKelas {
  int? id;
  int? userId;
  String? nip;
  String? namaGuru;
  String? createdAt;
  Null? updatedAt;

  WaliKelas(
      {this.id,
      this.userId,
      this.nip,
      this.namaGuru,
      this.createdAt,
      this.updatedAt});

  WaliKelas.fromJson(Map<String, dynamic> json) {
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

class DaftarMapel {
  int? id;
  String? namaMapel;
  String? createdAt;
  Null? updatedAt;

  DaftarMapel({this.id, this.namaMapel, this.createdAt, this.updatedAt});

  DaftarMapel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMapel = json['nama_mapel'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_mapel'] = this.namaMapel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}