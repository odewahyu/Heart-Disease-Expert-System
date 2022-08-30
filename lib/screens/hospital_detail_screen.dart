import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api.dart';
import '../constant.dart';
import '../models/rumah_sakit.dart';

class HospitalDetailScreen extends StatefulWidget {
  const HospitalDetailScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _HospitalDetailScreenState createState() => _HospitalDetailScreenState();
}

class _HospitalDetailScreenState extends State<HospitalDetailScreen> {
  Api api = Api();

  late Future<RumahSakit> _futureRumahSakit;
  late RumahSakit _rumahSakit;

  @override
  void initState() {
    super.initState();
    _futureRumahSakit = api.getDataRumahSakitById(widget.id.toString());
  }

  onDial(noTelephone) async {
    final Uri uriLaunch = Uri(scheme: "tel", path: noTelephone);
    if (await canLaunch(uriLaunch.toString())) {
      await launch(uriLaunch.toString());
    } else {
      throw Exception('Failed to dial');
    }
  }

  openMap(lat, long) async {
    String googleMapsUrl = "comgooglemaps://?center=$lat,$long";
    String appleMapsUrl = "https://maps.apple.com/?q=$lat,$long";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Couldnt launch';
    }
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
            color: kTextColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<RumahSakit>(
        future: _futureRumahSakit,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _rumahSakit = snapshot.data!;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: double.infinity,
                    child: Image.network(
                      api.baseUrl + '/storage/img-upload/' + _rumahSakit.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 25,
                      left: 25,
                      top: 30,
                      bottom: 20,
                    ),
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.21,
                    ),
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _rumahSakit.nama,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Text(
                                _rumahSakit.alamat,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone,
                              color: kPrimaryColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: Text(
                                _rumahSakit.noTelephone,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () =>
                                    onDial(_rumahSakit.noTelephone),
                                child: const Icon(
                                  Icons.phone,
                                  size: 35,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green[600],
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(
                                onPressed: () => openMap(
                                  _rumahSakit.latitude,
                                  _rumahSakit.longitude,
                                ),
                                child: const Icon(
                                  Icons.map,
                                  size: 35,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: kPrimaryColor,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
