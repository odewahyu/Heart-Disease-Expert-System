import 'package:flutter/material.dart';

import '../api.dart';
import '../constant.dart';
import '../screens/disease_detail_screen.dart';
import '../models/penyakit.dart';
import '../widget/penyakit_item.dart';

class DiseasesScreen extends StatefulWidget {
  const DiseasesScreen({Key? key}) : super(key: key);

  @override
  State<DiseasesScreen> createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
  Api api = Api();

  final TextEditingController _searchController = TextEditingController();

  late Future<List<Penyakit>> _futurePenyakit;
  late List<Penyakit> _penyakitList;
  String _keyword = '';

  @override
  void initState() {
    super.initState();
    _futurePenyakit = api.getPenyakitWithSearch(_keyword);
  }

  onSearch(value) {
    _keyword = value.toLowerCase();
    setState(() {
      _futurePenyakit = api.getPenyakitWithSearch(_keyword);
    });
  }

  onClear() {
    setState(() {
      _searchController.clear();
      _keyword = '';
      _futurePenyakit = api.getPenyakitWithSearch(_keyword);
    });
  }

  onTap(BuildContext context, String kode) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (contex) => DisesaseDetailScreen(
          kode: kode,
        ),
      ),
    );
  }

  Future<List<Penyakit>> onRefresh() {
    setState(() {
      _futurePenyakit = api.getPenyakitWithSearch(_keyword);
    });
    return _futurePenyakit;
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
              'Daftar Penyakit',
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
              decoration: InputDecoration(
                hintText: 'Cari panyakit....',
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
                child: FutureBuilder<List<Penyakit>>(
                  future: _futurePenyakit,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _penyakitList = snapshot.data!;
                      return ListView.builder(
                        itemCount: _penyakitList.length,
                        itemBuilder: (context, index) {
                          return PenyakitItem(
                            namaPenyakit: _penyakitList[index].namaPenyakit,
                            onTap: () => onTap(
                              context,
                              _penyakitList[index].kodePenyakit,
                            ),
                          );
                        },
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
