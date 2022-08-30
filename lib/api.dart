import 'dart:convert';

import 'package:http/http.dart' as http;

import './models/gejala.dart';
import './models/pengetahuan.dart';
import './models/penyakit.dart';
import './models/rumah_sakit.dart';

class Api {
  static const _baseUrl = 'http://sistem-pakar-app.test';

  String get baseUrl => _baseUrl;

  Future<List<Gejala>> getGejala() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/api/gejala'));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['data'];
        List<Gejala> list = data.map((e) => Gejala.fromJson(e)).toList();
        return list;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<Penyakit>> getPenyakit() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/api/penyakit'));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['data'];
        List<Penyakit> list = data.map((e) => Penyakit.fromJson(e)).toList();
        return list;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<List<Penyakit>> getPenyakitWithSearch(String? keyword) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/api/penyakit'));
      if (response.statusCode == 200) {
        if (keyword!.isNotEmpty) {
          var result = jsonDecode(response.body);
          Iterable data = result['data'];
          List<Penyakit> list = data.map((e) => Penyakit.fromJson(e)).toList();
          list = list.where((element) {
            String nama = element.namaPenyakit.toLowerCase();
            return nama.contains(keyword.toLowerCase());
          }).toList();
          return list;
        } else {
          var result = jsonDecode(response.body);
          Iterable data = result['data'];
          List<Penyakit> list = data.map((e) => Penyakit.fromJson(e)).toList();
          return list;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Penyakit> getPenyakitByKode(String kodePenyakit) async {
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + '/api/penyakit/' + kodePenyakit));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body)['data'];
        Penyakit data = Penyakit.fromJson(result);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<Pengetahuan>> getDataPengetahuan() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/api/pengetahuan'));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['data'];
        List<Pengetahuan> list =
            data.map((e) => Pengetahuan.fromJson(e)).toList();
        return list;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future createDataDiagnosa(Map<String, dynamic> diagnosa) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + '/api/diagnosa'),
        body: diagnosa,
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RumahSakit>> getDataRumahSakit(String? keyword) async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/api/rumah-sakit'));
      if (response.statusCode == 200) {
        if (keyword!.isNotEmpty) {
          var result = jsonDecode(response.body);
          Iterable data = result['data'];
          List<RumahSakit> list =
              data.map((e) => RumahSakit.fromJson(e)).toList();
          list = list.where((element) {
            String namaRs = element.nama.toLowerCase();
            String prov = element.provinsi.toLowerCase();
            return namaRs.contains(keyword.toLowerCase()) ||
                prov.contains(keyword.toLowerCase());
          }).toList();
          return list;
        } else {
          var result = jsonDecode(response.body);
          Iterable data = result['data'];
          List<RumahSakit> list =
              data.map((e) => RumahSakit.fromJson(e)).toList();
          return list;
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RumahSakit> getDataRumahSakitById(String id) async {
    try {
      final response =
          await http.get(Uri.parse(_baseUrl + '/api/rumah-sakit/' + id));
      if (response.statusCode == 200) {
        Map<String, dynamic> result = jsonDecode(response.body)['data'];
        RumahSakit data = RumahSakit.fromJson(result);
        return data;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
