import 'package:flutter/material.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:string_validator/string_validator.dart';

import '../constant.dart';
import '../screens/evidence_selection_screen.dart';

class IdentityScreen extends StatefulWidget {
  const IdentityScreen({Key? key}) : super(key: key);

  static const routName = '/identity';

  @override
  State<IdentityScreen> createState() => _IdentityScreenState();
}

class _IdentityScreenState extends State<IdentityScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _dropDownValue = 'Laki-Laki';
  bool nameErrorLabel = false;
  bool ageErrorLabel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Identitas Anda',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: kTextColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Masukan identitas anda',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          nameErrorLabel = true;
                          setState(() {});
                          return 'Masukan nama Anda';
                        } else if (!isAlpha(value)) {
                          nameErrorLabel = true;
                          setState(() {});
                          return 'Nama Anda tidak valid';
                        } else {
                          nameErrorLabel = false;
                          setState(() {});
                          return null;
                        }
                      },
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 20,
                        ),
                        labelText: 'Nama',
                        floatingLabelStyle: TextStyle(
                          color: (nameErrorLabel) ? Colors.red : kTextColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _ageController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          ageErrorLabel = true;
                          return 'Masukan umur Anda';
                        } else {
                          ageErrorLabel = false;
                          return null;
                        }
                      },
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 20,
                        ),
                        labelText: 'Umur',
                        floatingLabelStyle: TextStyle(
                          color: (ageErrorLabel) ? Colors.red : kTextColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropdownSearch(
                      validator: (value) {
                        if (value == null) {
                          return 'Masukan jenis kelamin anda';
                        } else {
                          return null;
                        }
                      },
                      mode: Mode.MENU,
                      maxHeight: 110,
                      onChanged: (value) {
                        setState(() {
                          _dropDownValue = value.toString();
                        });
                      },
                      items: const ['Laki-Laki', 'Perempuan'],
                      selectedItem: _dropDownValue,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 6,
                        ),
                        labelText: 'Jenis Kelamin',
                        floatingLabelStyle: const TextStyle(
                          color: kTextColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: kTextColor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushNamed(
                              EvidenceSelectionScreen.routeName,
                              arguments: {
                                'nama': _nameController.text,
                                'umur': int.parse(_ageController.text),
                                'jenis_kelamin': _dropDownValue,
                              },
                            );
                          }
                        },
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          padding: const EdgeInsets.all(20),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.01),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: kTextColor,
        ),
        onPressed: () => showDialog(
          context: context,
          builder: buildAlertDialog,
        ),
      ),
    );
  }

  Widget buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Batalkan diagnosa?',
        style: TextStyle(
          color: kTextColor,
        ),
      ),
      content: Text(
        'Anda akan membatalkan diagnosa penyakit.',
        style: TextStyle(
          color: Colors.grey[800],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Kembali',
          ),
          style: TextButton.styleFrom(
            primary: kTextColor,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/');
          },
          child: const Text(
            'OK',
          ),
          style: TextButton.styleFrom(
            primary: kTextColor,
          ),
        )
      ],
    );
  }
}
