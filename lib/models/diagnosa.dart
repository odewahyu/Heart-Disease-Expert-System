class Diagnosa {
  final String kodePenyakit;
  final String nama;
  final int umur;
  final String jenisKelamin;
  final double persentaseCF;
  final String tanggalDiagnosa;

  Diagnosa({
    required this.kodePenyakit,
    required this.nama,
    required this.umur,
    required this.jenisKelamin,
    required this.persentaseCF,
    required this.tanggalDiagnosa,
  });

  Map<String, dynamic> toJson() => {
        'kode_penyakit': kodePenyakit,
        'nama': nama,
        'umur': umur.toString(),
        'jenis_kelamin': jenisKelamin,
        'persentase_cf': persentaseCF.toString(),
        'tanggal_diagnosa': tanggalDiagnosa,
      };
}
