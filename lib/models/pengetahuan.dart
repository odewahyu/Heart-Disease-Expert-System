class Pengetahuan {
  final String kodeGejala;
  final String kodePenyakit;
  final double nilaiCF;

  Pengetahuan(
      {required this.kodeGejala,
      required this.kodePenyakit,
      required this.nilaiCF});

  factory Pengetahuan.fromJson(Map<String, dynamic> json) {
    return Pengetahuan(
      kodeGejala: json['kode_gejala'],
      kodePenyakit: json['kode_penyakit'],
      nilaiCF: json['nilai_cf'],
    );
  }
}
