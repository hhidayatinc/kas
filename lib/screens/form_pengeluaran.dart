import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kas/models/transakasi_model.dart';
import 'package:intl/intl.dart';

import '../db/db_helper.dart';

class FormPengeluaran extends StatefulWidget {
  final TransaksiModel? tm;
  const FormPengeluaran({Key? key, this.tm}) : super(key: key);

  @override
  State<FormPengeluaran> createState() => _FormPengeluaranState();
}

class _FormPengeluaranState extends State<FormPengeluaran> {
  TextEditingController tglController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  DbHelper db = DbHelper();
  DateTime? _dateTime;

  void _showDatePickerP() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        tglController.text = DateFormat('dd/MM/yyyy').format(_dateTime!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pemasukan')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Tanggal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: tglController,
                      readOnly: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                        ),
                        hintText: 'Pilih Tanggal',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Wajib Diisi';
                        }
                        return null;
                      },
                      onTap: _showDatePickerP,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Nominal',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: totalController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                        ),
                        prefixText: 'Rp. ',
                        hintText: 'Masukkan nominal',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Nominal';
                        }
                        return null;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Keterangan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                        ),
                        hintText: 'Tuliskan Keterangan',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Keterangan';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    tglController.text = DateFormat('dd/MM/yyyy')
                        .format(DateTime.utc(2021, 1, 1));
                    totalController.text = '';
                    nameController.text = '';
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.orange[400]),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Reset',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.replay_rounded)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await db.saveTransaksi(
                      TransaksiModel(
                          tanggal: tglController.text,
                          total: int.parse(totalController.text),
                          name: nameController.text,
                          type: 'Pengeluaran'),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Simpan',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.save_rounded)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.lightBlue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Kembali',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_back_ios)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}