import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kas/screens/detail_transaksi.dart';
import 'package:kas/screens/pengaturan.dart';

import '../components/GridViewWidget.dart';
import '../db/db_helper.dart';
import 'form_pemasukan.dart';
import 'form_pengeluaran.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DbHelper db = DbHelper();

  double totalIncome = 0;
  double totalExpense = 0;

  @override
  void initState() {
    super.initState();
    _loadTotal(); // Memuat total pemasukan saat widget pertama kali dibangun
  }

  Future<void> _loadTotal() async {
    double newTotalIncome = await db.getIncomeForMonth(
      DateTime.now().month.toString().padLeft(2, '0'),
      DateTime.now().year.toString(),
    );
    double newTotalExpense = await db.getExpenseForMonth(
      DateTime.now().month.toString().padLeft(2, '0'),
      DateTime.now().year.toString(),
    );
    setState(() {
      totalIncome = newTotalIncome;
      totalExpense = newTotalExpense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text('Rangkuman Bulan Ini',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            FutureBuilder(
              future: _loadTotal(),
              builder: (context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 72, 60),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(10, 16),
                            blurRadius: 15,
                            spreadRadius: -20,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Pengeluaran',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${totalExpense.toString()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 40, 202, 102),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(10, 16),
                            blurRadius: 15,
                            spreadRadius: -20,
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Pemasukan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rp ${totalIncome.toString()}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                children: [
                  GridViewWidget(
                    title: 'Tambah Pemasukan',
                    img: 'img/wallet.png',
                    nextPage: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const FormPemasukan()),
                      );
                    },
                  ), //2
                  GridViewWidget(
                    title: 'Tambah Pengeluaran',
                    img: 'img/expenses.png',
                    nextPage: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const FormPengeluaran()),
                      );
                    },
                  ), //3
                  GridViewWidget(
                    title: 'Detail Cash Flow',
                    img: 'img/budget.png',
                    nextPage: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const DetailTransaksi()),
                      );
                    },
                  ),
                  //4
                  GridViewWidget(
                    title: 'Pengaturan',
                    img: 'img/settings.png',
                    nextPage: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (contex) => const Pengaturan()),
                      );
                    },
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}