import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constant.dart';
import '../models/hasil.dart';
import '../screens/disease_detail_screen.dart';
import '../screens/identity_screen.dart';
import '../widget/result_item.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Iterable<Hasil>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.01),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          top: 0,
          bottom: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Column(
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 3,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 55,
                          ),
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...args
                                  .map(
                                    (e) => ResultItem(
                                      namaPenyakit: e.namaPenyakit,
                                      persentaseCF: e.persentaseCF,
                                    ),
                                  )
                                  .toList(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0, bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '*',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 17,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              'Berdasarkan hasil diagnosa, kemungkinan Anda mengalami ',
                                          style: TextStyle(
                                            color: Colors.grey[800],
                                            fontFamily: 'Montserrat',
                                            fontSize: 14,
                                          ),
                                          children: [
                                            TextSpan(
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () =>
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            DisesaseDetailScreen(
                                                                kode: args.first
                                                                    .kodePenyakit),
                                                      ),
                                                    ),
                                              text: args.first.namaPenyakit,
                                              style: const TextStyle(
                                                color: kTextColor,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 1.5,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: ' sebesar ',
                                            ),
                                            TextSpan(
                                              text:
                                                  '${args.first.persentaseCF.toStringAsFixed(2)}%',
                                              style: const TextStyle(
                                                color: kTextColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const TextSpan(
                                              text: '.',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/report.svg',
                                color: Colors.white,
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                'Hasil Diagnosa',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                          IdentityScreen.routName,
                        );
                      },
                      icon: const Icon(
                        Icons.loop,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Ulangi Diagnosa',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kTextColor,
                        padding: const EdgeInsets.all(15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed(
                          '/',
                        );
                      },
                      icon: SvgPicture.asset(
                        'assets/icons/stethoscope.svg',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'Menu Utama',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: const EdgeInsets.all(15),
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
            )
          ],
        ),
      ),
    );
  }
}
