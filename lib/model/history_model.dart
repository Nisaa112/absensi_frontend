class HistoryModel {
  final String id;
  final String namaMapel;
  final String tanggal;
  final String waktu;
  final String status;
  final bool isValid;

  HistoryModel({
    required this.id,
    required this.namaMapel,
    required this.tanggal,
    required this.waktu,
    required this.status,
    required this.isValid,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'].toString(),
      namaMapel: json['sesi']['jadwal']['mapel']['nama_mapel'] ?? 'Tanpa Nama',
      tanggal: json['sesi']['tanggal'],
      waktu: json['waktu_scan'],
      status: json['status'],
      isValid: json['is_valid'] == 1,
    );
  }
}