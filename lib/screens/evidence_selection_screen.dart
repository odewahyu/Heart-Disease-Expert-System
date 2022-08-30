import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api.dart';
import '../constant.dart';
import '../models/gejala.dart';
import '../models/hasil.dart';
import '../models/diagnosa.dart';
import '../models/pengetahuan.dart';
import '../models/penyakit.dart';
import '../screens/result_screen.dart';
import '../widget/gejala_item.dart';

class EvidenceSelectionScreen extends StatefulWidget {
  const EvidenceSelectionScreen({Key? key}) : super(key: key);

  static const routeName = '/evidence-selection';

  @override
  _EvidenceSelectionScreenState createState() =>
      _EvidenceSelectionScreenState();
}

class _EvidenceSelectionScreenState extends State<EvidenceSelectionScreen> {
  Api api = Api();

  late Future<List<Gejala>> _futureGejala;
  late List<Gejala> _gejalaList;
  final List<String> _gejalaTerpilih = [];

  List<Penyakit> _penyakitList = [];

  List<Pengetahuan> _pengetahuanList = [];

  List<Hasil> hasil = [];

  getData() async {
    _penyakitList = await api.getPenyakit();
    _pengetahuanList = await api.getDataPengetahuan();
  }

  @override
  void initState() {
    getData();
    super.initState();
    _futureGejala = api.getGejala();
  }

  createPasienData(
    BuildContext context,
    String kodePenyakit,
    String nama,
    int umur,
    String jenisKelamin,
    double persentaseCF,
  ) async {
    Map<String, dynamic> diagnosaData = Diagnosa(
            kodePenyakit: kodePenyakit,
            nama: nama,
            umur: umur,
            jenisKelamin: jenisKelamin,
            persentaseCF: persentaseCF,
            tanggalDiagnosa:
                DateFormat('y-MM-d').format(DateTime.now()).toString())
        .toJson();

    bool response = await api.createDataDiagnosa(diagnosaData);

    if (response) {
      Navigator.of(context).pushNamed(
        ResultScreen.routeName,
        arguments: hasil.reversed,
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          titleTextStyle: const TextStyle(
            color: kTextColor,
          ),
          content: Text(
            'Terjadi kesalahan, Anda gagal melakukan diagnosa penyakit',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.loop,
                color: kTextColor,
              ),
              label: const Text('Ulangi'),
              style: TextButton.styleFrom(
                primary: kTextColor,
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        ),
      );
    }
  }

  getHasil(String nama, int umur, String jenisKelamin) {
    for (Penyakit penyakit in _penyakitList) {
      double cfGabungan = 0;
      int i = 0;

      var pengetahuanTerpilih = _pengetahuanList
          .where((element) => element.kodePenyakit == penyakit.kodePenyakit);

      for (var pengetahuan in pengetahuanTerpilih) {
        double cf = pengetahuan.nilaiCF;
        for (var gejala in _gejalaTerpilih) {
          if (pengetahuan.kodeGejala == gejala) {
            if (i > 1) {
              cfGabungan = cf + (cfGabungan * (1 - cf));
            } else if (i == 1) {
              cfGabungan = cfGabungan + (cf * (1 - cfGabungan));
            } else {
              cfGabungan = cf;
            }
            i++;
          }
        }
      }
      hasil.add(
        Hasil(
          kodePenyakit: penyakit.kodePenyakit,
          namaPenyakit: penyakit.namaPenyakit,
          persentaseCF: cfGabungan * 100,
        ),
      );
    }

    hasil.sort((a, b) => a.persentaseCF.compareTo(b.persentaseCF));

    createPasienData(
      context,
      hasil.reversed.first.kodePenyakit,
      nama,
      umur,
      jenisKelamin,
      double.parse(hasil.reversed.first.persentaseCF.toStringAsFixed(2)),
    );
  }

  void onChanged(value, index, gejala, gejalaTerpilih) {
    setState(() {
      gejala[index].isSelected = value!;
      (gejala[index].isSelected)
          ? gejalaTerpilih.add(_gejalaList[index].kodeGejala)
          : gejalaTerpilih.remove(_gejalaList[index].kodeGejala);
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.01),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: kTextColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 15),
        child: Column(
          children: [
            const Text(
              'Daftar Gejala',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Pilih gejala yang anda alami',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<List<Gejala>>(
                future: _futureGejala,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    _gejalaList = snapshot.data!;
                    return ListView.builder(
                      itemCount: _gejalaList.length,
                      itemBuilder: (context, index) {
                        return GejalaItem(
                          gejalaTitle: _gejalaList[index].namaGejala,
                          gejalaValue: _gejalaList[index].isSelected,
                          onChanged: (value) => onChanged(
                            value,
                            index,
                            _gejalaList,
                            _gejalaTerpilih,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'There is an error',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_gejalaTerpilih.isNotEmpty)
                    ? () => getHasil(
                          args['nama'],
                          args['umur'],
                          args['jenis_kelamin'],
                        )
                    : null,
                child: const Text(
                  'Diagnosa Penyakit',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: const EdgeInsets.all(18),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
