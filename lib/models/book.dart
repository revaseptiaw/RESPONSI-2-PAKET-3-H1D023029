class Book {
  int id;
  String judul;
  int harga;
  int jumlah;
  String tanggalMasuk;
  int volume;
  String penulis;
  String penerbit;

  Book({
    required this.id,
    required this.judul,
    required this.harga,
    required this.jumlah,
    required this.tanggalMasuk,
    required this.volume,
    required this.penulis,
    required this.penerbit,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    judul: json["judul"],
    harga: json["harga"],
    jumlah: json["jumlah"],
    tanggalMasuk: json["tanggalMasuk"],
    volume: json["volume"],
    penulis: json["penulis"],
    penerbit: json["penerbit"],
  );
}
