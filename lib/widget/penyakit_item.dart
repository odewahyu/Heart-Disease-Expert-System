import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant.dart';

class PenyakitItem extends StatelessWidget {
  final String namaPenyakit;
  final VoidCallback onTap;

  const PenyakitItem(
      {Key? key, required this.namaPenyakit, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      color: kPrimaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 20,
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 22,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: SvgPicture.asset(
              'assets/icons/heart.svg',
              color: Colors.red[600],
            ),
          ),
        ),
        title: Text(
          namaPenyakit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onTap: onTap,
      ),
    );
  }
}
