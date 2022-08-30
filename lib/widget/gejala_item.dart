import 'package:flutter/material.dart';

import '../constant.dart';

class GejalaItem extends StatelessWidget {
  final String gejalaTitle;
  final bool gejalaValue;
  final dynamic onChanged;

  const GejalaItem(
      {Key? key,
      required this.gejalaTitle,
      required this.gejalaValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(gejalaTitle),
      activeColor: kPrimaryColor,
      value: gejalaValue,
      onChanged: onChanged,
    );
  }
}
