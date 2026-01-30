class guruModel {
  int? id;
  int? userId;
  String? nip;
  String? namaGuru;
  String? createdAt;
  String? updatedAt;

  guruModel(
      {this.id,
      this.userId,
      this.nip,
      this.namaGuru,
      this.createdAt,
      this.updatedAt});

  guruModel.fromJson(Map<String, dynamic> json) {
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