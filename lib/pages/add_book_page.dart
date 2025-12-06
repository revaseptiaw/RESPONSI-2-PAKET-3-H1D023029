import 'package:flutter/material.dart';
import '../api/api_service.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final judul = TextEditingController();
  final harga = TextEditingController();
  final jumlah = TextEditingController();
  final tanggalMasuk = TextEditingController();
  final volume = TextEditingController();
  final penulis = TextEditingController();
  final penerbit = TextEditingController();

  void save() async {
    await ApiService.addBook({
      "judul": judul.text,
      "harga": int.parse(harga.text),
      "jumlah": int.parse(jumlah.text),
      "tanggalMasuk": tanggalMasuk.text,
      "volume": int.parse(volume.text),
      "penulis": penulis.text,
      "penerbit": penerbit.text,
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Berhasil"),
        content: const Text("Buku berhasil ditambahkan!"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Inventaris Reremart")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          field("Judul", judul),
          field("Harga", harga),
          field("Jumlah", jumlah),
          field("Tanggal Masuk", tanggalMasuk),
          field("Volume", volume),
          field("Penulis", penulis),
          field("Penerbit", penerbit),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: save, child: const Text("Simpan")),
        ],
      ),
    );
  }

  Widget field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
