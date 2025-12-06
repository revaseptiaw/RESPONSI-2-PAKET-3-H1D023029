import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Map book;
  final Function() onDetail;
  final Function() onEdit;
  final Function() onDelete;

  const BookCard({
    super.key,
    required this.book,
    required this.onDetail,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(book["judul"]),
        subtitle: Text("Penulis: ${book["penulis"]}\nHarga: ${book["harga"]}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDetail,
              icon: const Icon(Icons.info, color: Colors.blue),
            ),
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, color: Colors.brown),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
