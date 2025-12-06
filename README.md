# Reremart Inventory App – REST API dan Frontend

Aplikasi ini merupakan sistem manajemen inventori buku dengan fitur CRUD lengkap. Backend dibangun menggunakan Node.js, Express, dan LowDB, sedangkan frontend menggunakan HTML dan JavaScript murni.

---

## Identitas Mahasiswa

- Nama: Reva Septia Wulandari  
- NIM: H1D023029
- Shift Baru: F
- Shift Asal: D

---

## Video Demo Aplikasi
https://github.com/user-attachments/assets/53710818-b055-4724-a7dc-c0dae783997d

---

## Spesifikasi API

| Endpoint          | Metode | Body / Respons | Keterangan |
|-----------------|--------|----------------|------------|
| `/register` | POST | Body: `{ email, password }` <br>Respons: `{ success: true/false, message }` | Mendaftarkan user baru. ID dibuat otomatis menggunakan nanoid. |
| `/login` | POST | Body: `{ email, password }` <br>Respons: `{ success: true/false, message, user }` | Melakukan autentikasi user. Jika valid, dikembalikan ID dan email. |
| `/users` | GET | Respons: Array user | Mengambil seluruh user yang tersimpan di db.json. Digunakan untuk administrasi atau debugging. |
| `/books` | GET | Respons: Array buku | Mengambil seluruh buku dari db.json (fungsi getBooks). |
| `/books` | POST | Body: `{ judul, harga, jumlah, tanggalMasuk, volume, penulis, penerbit }` <br>Respons: `{ success: true, message, book }` | Menambahkan buku baru ke database (fungsi createBook). ID buku dibuat otomatis menggunakan nanoid. |
| `/books/:id` | PUT | Body: `{ judul, harga, jumlah, tanggalMasuk, volume, penulis, penerbit }` <br>Respons: `{ success: true, message, book }` | Memperbarui data buku berdasarkan ID tertentu (fungsi updateBook). |
| `/books/:id` | DELETE | Respons: `{ success: true, message }` | Menghapus buku berdasarkan ID tertentu (fungsi deleteBook). |

---

## Penjelasan Kode Backend

### 1. Fungsi getBooks
```js
app.get('/books', async (req, res) => {
  await db.read();
  res.json(db.data.books);
});
```
Fungsi ini mengambil seluruh data buku dari database dan mengirimkannya ke client dalam format JSON. Fungsi ini digunakan pada halaman utama untuk menampilkan daftar inventori buku.

### 2. Fungsi createBook
```js
app.post('/books', async (req, res) => {
  const newBook = { id: "b_" + nanoid(), ...req.body };
  await db.read();
  db.data.books.push(newBook);
  await db.write();
  res.json({ success: true, message: "Buku ditambah", book: newBook });
});
```
Fungsi ini menambahkan buku baru ke database dengan ID unik yang dihasilkan secara otomatis. Data buku disimpan dalam array books di file db.json dan dikembalikan sebagai respons sukses.

### 3. Fungsi updateBook
```js
app.put('/books/:id', async (req, res) => {
  const { id } = req.params;
  await db.read();
  const idx = db.data.books.findIndex(b => b.id === id);
  if (idx === -1) return res.json({ success: false, message: "Buku tidak ditemukan" });
  db.data.books[idx] = { ...db.data.books[idx], ...req.body };
  await db.write();
  res.json({ success: true, message: "Buku diupdate", book: db.data.books[idx] });
});
```
Fungsi ini mencari buku berdasarkan ID. Jika ditemukan, data buku diperbarui sesuai dengan data yang dikirimkan melalui body request dan disimpan kembali ke database.

### 4. Fungsi deleteBook
```js
app.delete('/books/:id', async (req, res) => {
  const { id } = req.params;
  await db.read();
  db.data.books = db.data.books.filter(b => b.id !== id);
  await db.write();
  res.json({ success: true, message: "Buku dihapus" });
});
```
Fungsi ini menghapus buku dari database berdasarkan ID tertentu. Data buku yang dihapus difilter dari array books, kemudian perubahan disimpan ke file db.json.

### 4. Fungsi register
```js
app.post('/register', async (req, res) => {
  const { email, password } = req.body;
  await db.read();
  const exist = db.data.users.find(u => u.email === email);
  if (exist) return res.json({ success: false, message: "Email sudah terdaftar" });
  const newUser = { id: "u_" + nanoid(), email, password };
  db.data.users.push(newUser);
  await db.write();
  res.json({ success: true, message: "Register berhasil, silakan login." });
});
```
Fungsi ini mendaftarkan user baru jika email belum digunakan, kemudian menyimpan data ke database dan mengembalikan respons sukses.

### 4. Fungsi register
```js
app.post('/login', async (req, res) => {
  const { email, password } = req.body;
  await db.read();
  const user = db.data.users.find(u => u.email === email && u.password === password);
  if (!user) return res.json({ success: false, message: "Email atau password salah" });
  res.json({ success: true, message: "Login berhasil", user: { id: user.id, email: user.email } });
});
```
Fungsi ini melakukan autentikasi user berdasarkan email dan password. Jika valid, informasi user dikirimkan sebagai respons.


## Penjelasan Kode Frontend
### 1. Fungsi loadBooks
```js
async function loadBooks() {
  const res = await fetch("/books");
  const data = await res.json();
  const tbody = document.querySelector("#book-table");
  tbody.innerHTML = "";
  data.forEach(book => {
    tbody.innerHTML += `
      <tr>
        <td>${book.judul}</td>
        <td>${book.penulis}</td>
        <td>${book.harga}</td>
        <td>${book.jumlah}</td>
        <td>
          <button onclick="editBook('${book.id}')">Edit</button>
          <button onclick="deleteBook('${book.id}')">Hapus</button>
        </td>
      </tr>
    `;
  });
}
});
```
Fungsi ini mengambil seluruh data buku dari backend dan menampilkannya dalam tabel HTML, dengan tombol edit dan hapus untuk setiap buku.

### 2. Fungsi saveBook
```js
async function saveBook() {
  const id = document.querySelector("#id").value;
  const data = {
    judul: document.querySelector("#judul").value,
    penulis: document.querySelector("#penulis").value,
    harga: document.querySelector("#harga").value,
    jumlah: document.querySelector("#jumlah").value,
    tanggalMasuk: document.querySelector("#tanggalMasuk").value,
    volume: document.querySelector("#volume").value
  };
  if (id) {
    await fetch(`/books/${id}`, { method: "PUT", headers: { "Content-Type": "application/json" }, body: JSON.stringify(data) });
  } else {
    await fetch("/books", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(data) });
  }
  loadBooks();
}

```
Fungsi ini membaca input dari form. Jika form berisi ID buku, dilakukan pembaruan; jika tidak, dilakukan penambahan buku baru. Setelah selesai, tabel buku diperbarui.

### 3. Fungsi deleteBook
```js
async function deleteBook(id) {
  await fetch(`/books/${id}`, { method: "DELETE" });
  loadBooks();
}
```
Fungsi ini menghapus buku berdasarkan ID, kemudian memperbarui tabel buku.

### 4. Fungsi editBook
```js
async function editBook(id) {
  const res = await fetch(`/books/${id}`);
  const book = await res.json();
  document.querySelector("#id").value = book.id;
  document.querySelector("#judul").value = book.judul;
  document.querySelector("#penulis").value = book.penulis;
  document.querySelector("#harga").value = book.harga;
  document.querySelector("#jumlah").value = book.jumlah;
  document.querySelector("#tanggalMasuk").value = book.tanggalMasuk;
  document.querySelector("#volume").value = book.volume;
}
```
Fungsi ini mengambil data buku tertentu dan menampilkannya pada form agar dapat diedit.

## Alur CRUD Aplikasi Reremart Inventory

1. **Frontend mengirim request**  
   Frontend memanggil endpoint backend (`GET`, `POST`, `PUT`, `DELETE`) menggunakan fungsi `fetch()` sesuai aksi yang dilakukan pengguna, seperti menampilkan daftar buku, menambah buku baru, memperbarui, atau menghapus buku.

2. **Backend memproses request**  
   Backend menerima request, lalu memprosesnya menggunakan Sequelize untuk berinteraksi dengan database. Proses ini mencakup validasi data, pencarian record, pembaruan, atau penghapusan data.

3. **Database membaca atau menulis data**  
   Database melakukan operasi sesuai instruksi backend, baik membaca data buku, menambah buku baru, memperbarui, atau menghapus data.

4. **Backend mengembalikan respons JSON**  
   Setelah operasi selesai, backend mengirimkan respons dalam format JSON berisi data buku, pesan sukses, atau informasi error jika terjadi kegagalan.

5. **Frontend memperbarui tampilan tabel buku**  
   Data dari respons backend diterima frontend, lalu ditampilkan pada tabel HTML. Tabel diperbarui secara real-time setelah setiap operasi CRUD agar pengguna melihat data terbaru tanpa perlu memuat ulang halaman.
