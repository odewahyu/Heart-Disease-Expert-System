import 'package:flutter/material.dart';

import '../api.dart';
import '../constant.dart';
import '../models/rumah_sakit.dart';
import '../screens/hospital_detail_screen.dart';
import '../widget/rumah_sakit_item.dart';

class HospitalScreen extends StatefulWidget {
  const HospitalScreen({Key? key}) : super(key: key);

  @override
  State<HospitalScreen> createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  Api api = Api();

  final TextEditingController _searchController = TextEditingController();

  late Future<List<RumahSakit>> _futureRumahSakit;
  late List<RumahSakit> _rumahSakitList;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _futureRumahSakit = api.getDataRumahSakit(_keyword);
  }

  onSearch(value) {
    _keyword = value.toLowerCase();
    setState(() {
      _futureRumahSakit = api.getDataRumahSakit(_keyword);
    });
  }

  onClear() {
    setState(() {
      _searchController.clear();
      _keyword = '';
      _futureRumahSakit = api.getDataRumahSakit(_keyword);
    });
  }

  onTap(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (contex) => HospitalDetailScreen(
          id: id,
        ),
      ),
    );
  }

  Future<List<RumahSakit>> onRefresh() {
    setState(() {
      _futureRumahSakit = api.getDataRumahSakit(_keyword);
    });
    return _futureRumahSakit;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.01),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 25,
          left: 25,
          bottom: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Daftar Rumah Sakit',
              style: TextStyle(
                color: kTextColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: _searchController,
              autocorrect: false,
              onChanged: (value) => onSearch(value),
              // textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Cari rumah sakit....',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: (_keyword.isNotEmpty)
                    ? IconButton(
                        onPressed: onClear,
                        icon: const Icon(Icons.close),
                        iconSize: 20,
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: kTextColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => onRefresh(),
                child: FutureBuilder<List<RumahSakit>>(
                  future: _futureRumahSakit,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text(
                            'Tidak Ada Data',
                            style: TextStyle(
                              color: kTextColor,
                              fontSize: 18,
                            ),
                          ),
                        );
                      } else {
                        _rumahSakitList = snapshot.data!;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: _rumahSakitList.length,
                          itemBuilder: (context, index) {
                            return RumahSakitItem(
                              nama: _rumahSakitList[index].nama,
                              alamat: _rumahSakitList[index].alamat,
                              onTap: () =>
                                  onTap(context, _rumahSakitList[index].id),
                            );
                          },
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
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
            )
          ],
        ),
      ),
    );
  }
}
