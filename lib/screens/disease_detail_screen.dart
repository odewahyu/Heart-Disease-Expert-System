import 'package:flutter/material.dart';

import '../api.dart';
import '../constant.dart';
import '../models/penyakit.dart';

class DisesaseDetailScreen extends StatefulWidget {
  const DisesaseDetailScreen({Key? key, required this.kode}) : super(key: key);

  final String kode;

  @override
  _DisesaseDetailScreenState createState() => _DisesaseDetailScreenState();
}

class _DisesaseDetailScreenState extends State<DisesaseDetailScreen> {
  Api api = Api();

  late Future<Penyakit> _futurePenyakit;
  late Penyakit _penyakit;

  @override
  void initState() {
    super.initState();
    _futurePenyakit = api.getPenyakitByKode(widget.kode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.01),
        elevation: 0,
        leading: IconButton(
          splashRadius: 25,
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<Penyakit>(
        future: _futurePenyakit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _penyakit = snapshot.data!;
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      stops: [
                        0.10,
                        0.85,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF0a1931),
                        Color(0xFF185adb),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/virus.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      _penyakit.namaPenyakit,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.30),
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 15,
                    left: 25,
                    right: 25,
                  ),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Keterangan:',
                          style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SelectableText(
                          _penyakit.keterangan,
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Penanganan:',
                          style: TextStyle(
                            color: kTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SelectableText(
                          _penyakit.penanganan,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
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
    );
  }
}
