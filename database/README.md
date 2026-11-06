# Database CMS Web Profil Sekolah

## Instalasi awal

1. Buat database dan user MySQL/MariaDB di cPanel.
2. Berikan user database hak akses **ALL PRIVILEGES**.
3. Pilih database yang benar di phpMyAdmin.
4. Import file `schema.sql` satu kali.
5. Setelah file aplikasi terbaru diunggah, buka `/setup` untuk membuat akun Administrator pertama.
6. Setelah akun dibuat, login melalui `/login`.

## Catatan

- Skema ini ditujukan untuk instalasi baru/kosong.
- Jangan jalankan ulang pada database produksi yang sudah berisi data tanpa backup dan pemeriksaan terlebih dahulu.
- File ini membuat tabel inti CMS, role Administrator dan Editor, serta satu baris profil sekolah awal.
- Akun administrator tidak dibuat melalui SQL. Akun pertama dibuat melalui halaman setup agar password disimpan menggunakan `password_hash()`.
- Jangan pernah memasukkan file `.env` ke repository Git.

## Tabel inti

- `roles`, `users`, `role_permissions`: akun dan hak akses.
- `school_profile`, `site_settings`: identitas dan konfigurasi sekolah.
- `pages`: halaman statis.
- `news_categories`, `news_posts`: berita.
- `announcements`: pengumuman.
- `staff`: guru dan tenaga kependidikan.
- `facilities`, `achievements`: fasilitas dan prestasi.
- `galleries`, `gallery_items`: galeri foto.
- `menus`, `menu_items`: navigasi website.
- `media_library`: pustaka media.
- `feedback_submissions`: pengaduan, kritik, dan saran dari pengunjung, termasuk status tindak lanjut dan catatan admin.
- `audit_logs`: catatan aktivitas.

## Modul pengaduan, kritik, dan saran

Tabel `feedback_submissions` menyimpan jenis masukan (pengaduan/kritik/saran), identitas pengirim yang boleh dikosongkan, subjek, isi pesan, status tindak lanjut (`new`, `in_review`, `responded`, `closed`), catatan internal admin, dan balasan admin. Pengelolaan data dilakukan melalui panel admin pada tahap implementasi modul.

Versi skema: **1.1**
