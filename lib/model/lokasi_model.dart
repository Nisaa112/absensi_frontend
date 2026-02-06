class LokasiModel {
  final double latitude;
  final double longitude;
  final double radius;

  LokasiModel({required this.latitude, required this.longitude, required this.radius});

  factory LokasiModel.fromJson(Map<String, dynamic> json) {
    return LokasiModel(
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      radius: double.parse(json['radius'].toString()),
    );
  }
}