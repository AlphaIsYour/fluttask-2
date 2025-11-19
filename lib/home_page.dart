// lib/home_page.dart
import 'dart:async'; // Import untuk StreamSubscription

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart'; // Import Firebase Database

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Dapatkan referensi ke node 'messages' di Realtime Database
  // Ini akan menyimpan daftar pesan kita
  final DatabaseReference _messagesRef = FirebaseDatabase.instance.ref(
    'messages',
  );

  // List untuk menyimpan pesan yang diambil dari database
  List<String> _messages = [];

  // StreamSubscription untuk mendengarkan perubahan data secara real-time
  late StreamSubscription<DatabaseEvent> _messagesSubscription;

  @override
  void initState() {
    super.initState();
    // Mulai mendengarkan perubahan di node 'messages'
    _messagesSubscription = _messagesRef.onValue.listen(
      (event) {
        final data = event.snapshot.value; // Dapatkan data terbaru
        if (data != null && data is Map) {
          _messages.clear(); // Hapus pesan lama
          // Iterasi melalui data (yang berupa Map) dan tambahkan ke list pesan
          (data as Map).forEach((key, value) {
            if (value is Map && value.containsKey('text')) {
              _messages.add(value['text'] as String);
            }
          });
          setState(() {}); // Perbarui UI
        } else {
          _messages.clear(); // Kosongkan pesan jika tidak ada data
          setState(() {});
        }
      },
      onError: (error) {
        print('Error mendengarkan pesan: $error');
        // Tampilkan SnackBar atau dialog jika ada error
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat pesan: $error')));
      },
    );
  }

  @override
  void dispose() {
    // Batalkan langganan stream saat widget dihapus untuk mencegah memory leaks
    _messagesSubscription.cancel();
    super.dispose();
  }

  // Fungsi untuk menambahkan pesan baru ke database
  Future<void> _addMessage() async {
    final user =
        FirebaseAuth.instance.currentUser; // Dapatkan user yang sedang login
    if (user != null) {
      // Gunakan push() untuk membuat key unik, lalu set data
      await _messagesRef.push().set({
        'text':
            'Pesan dari ${user.email ?? user.displayName ?? "Anonim"} pada ${DateTime.now().toIso8601String()}',
        'authorId': user.uid, // Simpan ID user yang menulis pesan
        'timestamp': ServerValue.timestamp, // Gunakan timestamp server
      });
    } else {
      // Tampilkan pesan error jika user belum login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anda perlu login untuk mengirim pesan!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page (Demo RTDB)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Logout user
            },
          ),
        ],
      ),
      body: _messages.isEmpty
          ? const Center(child: Text('Tidak ada pesan. Coba tambahkan satu!'))
          : ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_messages[index]),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMessage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
