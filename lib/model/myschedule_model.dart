class myscheduleModel {
  String? status;
  String? hariIni;
  List<Data>? data;

  myscheduleModel({this.status, this.hariIni, this.data});

  myscheduleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    hariIni = json['hari_ini'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['hari_ini'] = this.hariIni;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? kelasId;
  int? mapelId;
  int? guruId;
  int? lokasiId;
  String? hari;
  String? jamMulai;
  String? jamSelesai;
  String? createdAt;
  Null? updatedAt;
  Kelas? kelas;
  Mapel? mapel;
  Lokasi? lokasi;

  Data(
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
      this.lokasi});

  Data.fromJson(Map<String, dynamic> json) {
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
    if (this.lokasi != null) {
      data['lokasi'] = this.lokasi!.toJson();
    }
    return data;
  }
}

class Kelas {
  int? id;
  String? namaKelas;

  Kelas({this.id, this.namaKelas});

  Kelas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaKelas = json['nama_kelas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_kelas'] = this.namaKelas;
    return data;
  }
}

class Mapel {
  int? id;
  String? namaMapel;

  Mapel({this.id, this.namaMapel});

  Mapel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaMapel = json['nama_mapel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_mapel'] = this.namaMapel;
    return data;
  }
}

class Lokasi {
  int? id;
  String? namaLokasi;
  int? radius;

  Lokasi({this.id, this.namaLokasi, this.radius});

  Lokasi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaLokasi = json['nama_lokasi'];
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_lokasi'] = this.namaLokasi;
    data['radius'] = this.radius;
    return data;
  }
}