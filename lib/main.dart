import 'package:flutter/material.dart';
import 'package:fontresoft/fontresoft.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:flutter_animation_plus/flutter_animation_plus.dart';

void main(List<String> args) {
  runApp(const Belajar1());
}

class Belajar1 extends StatelessWidget {
  const Belajar1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Belajar2(),
    );
  }
}

class Belajar2 extends StatefulWidget {
  const Belajar2({super.key});

  @override
  State<Belajar2> createState() => _Belajar2State();
}

class _Belajar2State extends State<Belajar2> {
  TextEditingController isi = TextEditingController();
  String? isi2;
  double isislider = 0;
  bool kehadiran = false;
  bool hobiOlahraga = false;
  bool hobiMembaca = false;
  bool hobiBerenang = false;
  bool hobiMelamun = false;
  String? jenjang;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/image/logoub2.png", height: 50),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset("assets/image/logoub.jpg", fit: BoxFit.cover),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TypeWriter.text(
                    "Mahasiswa UB",
                    style: TextStyle(
                      fontFamily: FontResoft.poppins,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    duration: Duration(milliseconds: 100),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextField(
                      controller: isi,
                      decoration: const InputDecoration(
                        labelText: "Masukkan teks",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: DropdownButtonFormField<String>(
                      value: isi2,
                      hint: const Text("Pilih Jurusan"),
                      items: const [
                        DropdownMenuItem(
                          value: "Teknologi Informasi",
                          child: Text("Teknologi Informasi"),
                        ),
                        DropdownMenuItem(
                          value: "Ekonomi",
                          child: Text("Ekonomi"),
                        ),
                        DropdownMenuItem(
                          value: "Bahasa Inggris",
                          child: Text("Bahasa Inggris"),
                        ),
                        DropdownMenuItem(
                          value: "Matematika",
                          child: Text("Matematika"),
                        ),
                      ],
                      onChanged: (newValue) {
                        setState(() {
                          isi2 = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Text("Nilai: ${isislider.toStringAsFixed(0)}"),
                      Slider(
                        value: isislider,
                        min: 0,
                        max: 100,
                        divisions: 100,
                        onChanged: (value) {
                          setState(() {
                            isislider = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Hadir: ${kehadiran ? "Ya" : "Tidak"}"),
                      const SizedBox(width: 30),
                      Switch(
                        value: kehadiran,
                        onChanged: (status) {
                          setState(() {
                            kehadiran = status;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Column(
                    children: [
                      CheckboxListTile(
                        title: const Text("Olahraga"),
                        value: hobiOlahraga,
                        onChanged: (nilai) {
                          setState(() {
                            hobiOlahraga = nilai ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Membaca"),
                        value: hobiMembaca,
                        onChanged: (nilai) {
                          setState(() {
                            hobiMembaca = nilai ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Berenang"),
                        value: hobiBerenang,
                        onChanged: (nilai) {
                          setState(() {
                            hobiBerenang = nilai ?? false;
                          });
                        },
                      ),
                      CheckboxListTile(
                        title: const Text("Melamun"),
                        value: hobiMelamun,
                        onChanged: (nilai) {
                          setState(() {
                            hobiMelamun = nilai ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pilih Jenjang:"),
                      RadioListTile<String>(
                        title: const Text("D3"),
                        value: "D3",
                        groupValue: jenjang,
                        onChanged: (val) {
                          setState(() {
                            jenjang = val;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text("S1"),
                        value: "S1",
                        groupValue: jenjang,
                        onChanged: (val) {
                          setState(() {
                            jenjang = val;
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: const Text("S2"),
                        value: "S2",
                        groupValue: jenjang,
                        onChanged: (val) {
                          setState(() {
                            jenjang = val;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      String hasil =
                          "Nama: ${isi.text}\n"
                          "Jurusan: ${isi2 ?? ""}\n"
                          "Nilai : ${isislider.toStringAsFixed(0)}\n"
                          "Hadir : ${kehadiran ? "Hadir" : "Alpha"}\n"
                          "Hobi : "
                          "${hobiBerenang ? "Berenang " : ""}"
                          "${hobiMelamun ? "Melamun " : ""}\n"
                          "Jenjang : ${jenjang ?? "-"}";

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(hasil)));
                    },
                    child: const Text("Klik"),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
