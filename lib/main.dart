import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RealtimeExample(),
    );
  }
}

class RealtimeExample extends StatefulWidget {
  const RealtimeExample({super.key});

  @override
  State<RealtimeExample> createState() => _RealtimeExampleState();
}

class _RealtimeExampleState extends State<RealtimeExample> {
  final TextEditingController _controller = TextEditingController();

  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child(
    "pesan",
  );

  void _kirim() {
    if (_controller.text.isNotEmpty) {
      dbRef.push().set({
        "teks": _controller.text,
        "waktu": ServerValue.timestamp,
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Universitas Brawijaya")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Masukkan Nama",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(onPressed: _kirim, child: const Text("Kirim")),
              ],
            ),
            const SizedBox(height: 16),

            const Text("Data Inputan:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 8),

            Expanded(
              child: StreamBuilder(
                stream: dbRef.onValue,
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data?.snapshot.value != null) {
                    final data = snapshot.data!.snapshot.value as Map;

                    final List items = data.entries.toList()
                      ..sort(
                        (a, b) =>
                            (b.value['waktu'] ?? 0).compareTo(a.value['waktu']),
                      );

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        return ListTile(title: Text(items[i].value['teks']));
                      },
                    );
                  }
                  return const Center(child: Text("Belum ada data"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
