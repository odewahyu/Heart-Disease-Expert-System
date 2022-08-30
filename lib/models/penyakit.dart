class Penyakit {
  final String kodePenyakit;
  final String namaPenyakit;
  final String penanganan;
  final String keterangan;

  Penyakit({
    required this.kodePenyakit,
    required this.namaPenyakit,
    required this.penanganan,
    required this.keterangan,
  });

  factory Penyakit.fromJson(Map<String, dynamic> json) {
    return Penyakit(
      kodePenyakit: json['kode_penyakit'],
      namaPenyakit: json['nama_penyakit'],
      penanganan: json['penanganan'],
      keterangan: json['keterangan'],
    );
  }
}
