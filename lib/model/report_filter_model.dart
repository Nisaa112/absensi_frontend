class ReportFilter {
  String? tahunAjaranId;
  String? kelasId;
  
  Map<String, String> toParams() => {
    'tahun_ajaran_id': tahunAjaranId ?? '',
    'kelas_id': kelasId ?? '',
  };
}