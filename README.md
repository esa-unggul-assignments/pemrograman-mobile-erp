# Tugas ERP Pemrograman Mobile

Membuat aplikasi mobile yang terintegrasi dengan odoo dan postgres db yang di serve di docker, juga pgadmin untuk mengecek isi db.

1. Install docker, lalu pull image postgres:14, odoo:14, juga dpage/pgadmin4.

   - Cara 1: Ikuti [tutorial dari dosen](https://github.com/maztarigan/bootcamp)<br />
     Note: untuk mac, ganti command untuk instalasi odoo menjadi
     ```
     docker run -p 8069:8069  -d --platform linux/x86_64/v8 --name  erp14 --link dberp14:db -t odoo:14
     ```
   - Cara 2: Menggunakan `docker-compose.yml` yang sudah ada lalu jalankan command
     ```
     docker-compose up -d
     ```
     Note: untuk windows, buka `docker-compose.yml` terlebih dahulu dan hapus baris 15 yang berisi
     ```
     platform: linux/x86_64/v8
     ```

2. Buka odoo terlebih dahulu di `http://localhost:8069` untuk setup master password dan user/password odoo.

3. Install dependencies flutter sebelum menjalankan aplikasi dengan command

   ```
   flutter pub get
   ```

4. Run aplikasi flutter.<br />
   Note: untuk menjalankan aplikasi dengan chrome, ubah `baseUrl` di file `login_form.dart` line 20 menjadi
   ```
   http://localhost:8069
   ```

   Lalu run aplikasi flutter dengan command
   ```
   flutter run -d chrome --web-browser-flag "--disable-web-security"
   ```
