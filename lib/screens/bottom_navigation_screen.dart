import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

import '../constant.dart';
import '../screens/diseases_screen.dart';
import '../screens/home_screen.dart';
import '../screens/hospital_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late List<dynamic> _pages;
  int _selectedPageIndex = 1;

  @override
  void initState() {
    _pages = const [
      HospitalScreen(),
      HomeScreen(),
      DiseasesScreen(),
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: _selectedPageIndex == 0
                ? SvgPicture.asset(
                    'assets/icons/hospital.svg',
                    width: 24,
                    height: 24,
                    color: kPrimaryColor,
                  )
                : SvgPicture.asset(
                    'assets/icons/hospital.svg',
                    width: 24,
                    height: 24,
                    color: Colors.grey,
                  ),
            label: 'Rumah Sakit',
          ),
          BottomNavigationBarItem(
            icon: _selectedPageIndex == 1
                ? SvgPicture.asset(
                    'assets/icons/stethoscope.svg',
                    width: 25,
                    height: 25,
                    color: kPrimaryColor,
                  )
                : SvgPicture.asset(
                    'assets/icons/stethoscope.svg',
                    width: 24,
                    height: 24,
                    color: Colors.grey,
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedPageIndex == 2
                ? SvgPicture.asset(
                    'assets/icons/disease.svg',
                    width: 25,
                    height: 25,
                    color: kPrimaryColor,
                  )
                : SvgPicture.asset(
                    'assets/icons/disease.svg',
                    width: 24,
                    height: 24,
                    color: Colors.grey,
                  ),
            label: 'Penyakit',
          ),
        ],
      ),
    );
  }
}
