import 'package:flutter/material.dart';

import '/constant.dart';
import '/screens/bottom_navigation_screen.dart';
import '/screens/evidence_selection_screen.dart';
import '/screens/identity_screen.dart';
import '/screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Pakar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: kTextColor,
            ),
      ),
      routes: {
        '/': (context) => const BottomNavigationScreen(),
        IdentityScreen.routName: (context) => const IdentityScreen(),
        EvidenceSelectionScreen.routeName: (context) =>
            const EvidenceSelectionScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
    );
  }
}
