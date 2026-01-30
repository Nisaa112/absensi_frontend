class mapelModel {
  int? id;
  String? namaMapel;
  String? createdAt;
  String? updatedAt;

  mapelModel({this.id, this.namaMapel, this.createdAt, this.updatedAt});

  mapelModel.fromJson(Map<String, dynamic> json) {
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