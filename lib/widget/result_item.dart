import 'package:flutter/material.dart';

import '../constant.dart';

class ResultItem extends StatelessWidget {
  final String namaPenyakit;
  final double persentaseCF;

  const ResultItem(
      {Key? key, required this.namaPenyakit, required this.persentaseCF})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        namaPenyakit,
        style: const TextStyle(
          color: kTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      trailing: Text(
        persentaseCF.toStringAsFixed(2) + ' %',
        style: const TextStyle(
          color: kTextColor,
          fontSize: 17,
        ),
      ),
    );
  }
}
