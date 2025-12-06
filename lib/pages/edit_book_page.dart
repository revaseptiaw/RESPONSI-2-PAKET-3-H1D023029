import 'package:flutter/material.dart';
import '../api/api_service.dart';

class EditBookPage extends StatefulWidget {
  final Map book;
  const EditBookPage({super.key, required this.book});

  @override
  State<EditBookPage> createState() => _EditBookPageState();
}

class _EditBookPageState extends State<EditBookPage> {
  late TextEditingController judul;
  late TextEditingController harga;
  late TextEditingController jumlah;
  late TextEditingController tanggalMasuk;
  late TextEditingController volume;
  late TextEditingController penulis;
  late TextEditingController penerbit;

  @override
  void initState() {
    super.initState();

    // Debug untuk cek ID
    print("EDIT PAGE ID: ${widget.book['id']}");

    judul = TextEditingController(text: widget.book["judul"]);
    harga = TextEditingController(text: widget.book["harga"].toString());
    jumlah = TextEditingController(text: widget.book["jumlah"].toString());
    tanggalMasuk = TextEditingController(text: widget.book["tanggalMasuk"]);
    volume = TextEditingController(text: widget.book["volume"].toString());
    penulis = TextEditingController(text: widget.book["penulis"]);
    penerbit = TextEditingController(text: widget.book["penerbit"]);
  }

  void updateBook() async {
    if (widget.book["id"] == null) {
      print("❌ ERROR: ID buku tidak ditemukan!");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal: ID buku tidak valid")),
      );
      return;
    }

    try {
      await ApiService.updateBook(widget.book["id"], {
        "judul": judul.text,
        "harga": int.tryParse(harga.text) ?? 0,
        "jumlah": int.tryParse(jumlah.text) ?? 0,
        "tanggalMasuk": tanggalMasuk.text,
        "volume": int.tryParse(volume.text) ?? 0,
        "penulis": penulis.text,
        "penerbit": penerbit.text,
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Berhasil"),
          content: const Text("Data buku berhasil diperbarui."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // tutup dialog
                Navigator.of(context).pop(); // kembali ke detail
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print("ERROR UPDATE: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terjadi kesalahan saat update")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Buku Reremart")),
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
          ElevatedButton(onPressed: updateBook, child: const Text("Update")),
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
