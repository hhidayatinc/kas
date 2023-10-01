import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kas/models/transakasi_model.dart';

import '../db/db_helper.dart';

class DetailTransaksi extends StatefulWidget {
  const DetailTransaksi({Key? key}) : super(key: key);

  @override
  State<DetailTransaksi> createState() => _DetailTransaksiState();
}

class _DetailTransaksiState extends State<DetailTransaksi> {
  List<TransaksiModel> listTM = [];
  DbHelper db = DbHelper();
  @override
  void initState() {
    // menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllTransaksi();
    super.initState();
  }

  Future<void> _getAllTransaksi() async {
    var list = await db.getAllTransaksi();
    setState(() {
      listTM.clear();
      list!.forEach((tm) {
        listTM.add(TransaksiModel.fromMap(tm));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cash Flow'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: listTM.length,
          itemBuilder: (BuildContext context, int index) {
            TransaksiModel tm = listTM[index];
            return Card(
              child: ListTile(
                title: Text(
                  '${tm.total}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${tm.name}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text('${tm.tanggal}')
                  ],
                ),
                trailing: Icon(
                  '${tm.type}' == 'Pemasukan'
                      ? Icons.arrow_back
                      : Icons.arrow_forward,
                  color: '${tm.type}' == 'Pemasukan'
                      ? const Color.fromARGB(255, 40, 202, 102)
                      : const Color.fromARGB(255, 228, 72, 60),
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      ),
    );
  }
}