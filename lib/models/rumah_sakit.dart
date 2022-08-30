class RumahSakit {
  final int id;
  final String nama;
  final String provinsi;
  final String alamat;
  final String noTelephone;
  final double latitude;
  final double longitude;
  final String image;

  RumahSakit({
    required this.id,
    required this.nama,
    required this.provinsi,
    required this.alamat,
    required this.noTelephone,
    required this.latitude,
    required this.longitude,
    required this.image,
  });

  factory RumahSakit.fromJson(Map<String, dynamic> json) {
    return RumahSakit(
      id: json['id_rs'],
      nama: json['nama_rs'],
      provinsi: json['provinsi'],
      alamat: json['alamat'],
      noTelephone: json['no_telephone'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      image: json['gambar'],
    );
  }
}
