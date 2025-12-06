import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'add_book_page.dart';
import 'edit_book_page.dart';
import 'book_detail_page.dart';
import '../widgets/book_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List books = [];

  void loadData() async {
    books = await ApiService.getBooks();
    setState(() {});
  }

  // ==============================
  //  KONFIRMASI HAPUS + HAPUS DATA
  // ==============================
  void deleteBook(String id) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Apakah Anda yakin ingin menghapus buku ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // TIDAK
            child: const Text("Tidak"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // tutup dialog konfirmasi

              await ApiService.deleteBook(id);

              loadData(); // langsung refresh tanpa popup sukses
            },
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventaris Buku Reremart")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddBookPage()),
          ).then((_) => loadData());
        },
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (_, i) {
          final b = books[i];
          return BookCard(
            book: b,
            onDetail: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => BookDetailPage(book: b)),
              );
            },
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EditBookPage(book: b)),
              ).then((_) => loadData());
            },
            onDelete: () => deleteBook(b["id"]), // Tombol hapus
          );
        },
      ),
    );
  }
}
