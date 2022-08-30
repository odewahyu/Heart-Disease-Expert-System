class Gejala {
  final String kodeGejala;
  final String namaGejala;
  bool isSelected;

  Gejala({
    required this.kodeGejala,
    required this.namaGejala,
    this.isSelected = false,
  });

  factory Gejala.fromJson(Map<String, dynamic> json) {
    return Gejala(
      kodeGejala: json['kode_gejala'],
      namaGejala: json['nama_gejala'],
    );
  }
}
