class jadwalModel {
  int? id;
  int? kelasId;
  int? mapelId;
  int? guruId;
  int? lokasiId;
  String? hari;
  String? jamMulai;
  String? jamSelesai;
  String? createdAt;
  String? updatedAt;
  Kelas? kelas;
  Mapel? mapel;
  Guru? guru;
  Lokasi? lokasi;

  jadwalModel(
      {this.id,
      this.kelasId,
      this.mapelId,
      this.guruId,
      this.lokasiId,
      this.hari,
      this.jamMulai,
      this.jamSelesai,
      this.createdAt,
      this.updatedAt,
      this.kelas,
      this.mapel,
      this.guru,
      this.lokasi});

  jadwalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kelasId = json['kelas_id'];
    mapelId = json['mapel_id'];
    guruId = json['guru_id'];
    lokasiId = json['lokasi_id'];
    hari = json['hari'];
    jamMulai = json['jam_mulai'];
    jamSelesai = json['jam_selesai'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    kelas = json['kelas'] != null ? new Kelas.fromJson(json['kelas']) : null;
    mapel = json['mapel'] != null ? new Mapel.fromJson(json['mapel']) : null;
    guru = json['guru'] != null ? new Guru.fromJson(json['guru']) : null;
    lokasi =
        json['lokasi'] != null ? new Lokasi.fromJson(json['lokasi']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['kelas_id'] = this.kelasId;
    data['mapel_id'] = this.mapelId;
    data['guru_id'] = this.guruId;
    data['lokasi_id'] = this.lokasiId;
    data['hari'] = this.hari;
    data['jam_mulai'] = this.jamMulai;
    data['jam_selesai'] = this.jamSelesai;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.kelas != null) {
      data['kelas'] = this.kelas!.toJson();
    }
    if (this.mapel != null) {
      data['mapel'] = this.mapel!.toJson();
    }
    if (this.guru != null) {
      data['guru'] = this.guru!.toJson();
    }
    if (this.lokasi != null) {
      data['lokasi'] = this.lokasi!.toJson();
    }
    return data;
  }
}

class Kelas {
  int? id;
  String? namaKelas;
  int? tahunAjaranId;
  int? waliKelasId;
  String? createdAt;
  String? updatedAt;

  Kelas(
      {this.id,
      this.namaKelas,
      this.tahunAjaranId,
      this.waliKelasId,
      this.createdAt,
      this.updatedAt});

  Kelas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKelas = json['nama_kelas'];
    tahunAjaranId = json['tahun_ajaran_id'];
    waliKelasId = json['wali_kelas_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kelas'] = this.namaKelas;
    data['tahun_ajaran_id'] = this.tahunAjaranId;
    data['wali_kelas_id'] = this.waliKelasId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Mapel {
  int? id;
  String? namaMapel;
  String? createdAt;
  String? updatedAt;

  Mapel({this.id, this.namaMapel, this.createdAt, this.updatedAt});

  Mapel.fromJson(Map<String, dynamic> json) {
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

class Guru {
  int? id;
  int? userId;
  String? nip;
  String? namaGuru;
  String? createdAt;
  String? updatedAt;

  Guru(
      {this.id,
      this.userId,
      this.nip,
      this.namaGuru,
      this.createdAt,
      this.updatedAt});

  Guru.fromJson(Map<String, dynamic> json) {
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

class Lokasi {
  int? id;
  String? namaLokasi;
  double? latitude;
  double? longitude;
  int? radius;
  String? createdAt;
  String? updatedAt;

  Lokasi(
      {this.id,
      this.namaLokasi,
      this.latitude,
      this.longitude,
      this.radius,
      this.createdAt,
      this.updatedAt});

  Lokasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaLokasi = json['nama_lokasi'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    radius = json['radius'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_lokasi'] = this.namaLokasi;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['radius'] = this.radius;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}