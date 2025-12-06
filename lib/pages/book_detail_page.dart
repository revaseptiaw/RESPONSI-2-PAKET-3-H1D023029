import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'edit_book_page.dart';

class BookDetailPage extends StatelessWidget {
  final Map book;
  const BookDetailPage({super.key, required this.book});

  void confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Buku"),
        content: const Text("Yakin ingin menghapus buku ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () async {
              // Hapus data
              await ApiService.deleteBook(book["id"]);

              // Tutup dialog
              Navigator.pop(context);

              // Tutup halaman detail dan kirim status sukses
              Navigator.pop(context, "deleted");
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book["judul"])),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Judul: ${book["judul"]}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Penulis: ${book["penulis"]}"),
            Text("Penerbit: ${book["penerbit"]}"),
            Text("Harga: ${book["harga"]}"),
            Text("Jumlah: ${book["jumlah"]}"),
            Text("Volume: ${book["volume"]}"),
            Text("Tanggal Masuk: ${book["tanggalMasuk"]}"),
            const SizedBox(height: 20),

            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditBookPage(book: book),
                      ),
                    );

                    // Jika edit sukses, refresh tampilan detail
                    if (result == "updated") {
                      Navigator.pop(context, "updated");
                    }
                  },
                  child: const Text("Edit"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => confirmDelete(context),
                  child: const Text("Hapus"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
