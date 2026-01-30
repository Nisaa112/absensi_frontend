class siswaModel {
  int? id;
  int? userId;
  String? nisn;
  String? namaSiswa;
  String? createdAt;
  String? updatedAt;

  siswaModel(
      {this.id,
      this.userId,
      this.nisn,
      this.namaSiswa,
      this.createdAt,
      this.updatedAt});

  siswaModel.fromJson(Map<String, dynamic> json) {
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