import 'package:flutter/material.dart';

import '../db/db_helper.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({Key? key}) : super(key: key);

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  TextEditingController passController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  DbHelper db = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //ganti password
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ganti Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Password Saat Ini',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: passController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                        ),
                        hintText: 'Masukkan password saat ini'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukkan Password';
                      }
                      return null;
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Password Baru:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    controller: newPassController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide:
                          const BorderSide(color: Colors.green, width: 2.0),
                        ),
                        hintText: 'Masukkan password baru'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Keterangan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? password = await db.getPassword();
                        if (passController.text == password) {
                          // ubah password
                          await db.updatePassword(newPassController.text);
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password berhasil diubah'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password salah'),
                            ),
                          );
                        }
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
            // about this app
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'img/2241727016.jpg',
                  height: 100,
                ),
                // const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'About This App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text('Aplikasi ini dibuat oleh:'),
                    Text('Nama: Hidayati Nur Chasanah'),
                    Text('NIM: 2241727016'),
                    Text('Tanggal: 1 Oktober 2023')
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}