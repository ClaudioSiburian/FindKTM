## Kelompok 4

Repository ini dibuat untuk memenuhi tugas Mata Kuliah **Teknologi Berkembang**.

## Anggota Kelompok

1. **Muhammad Aqzhara Fathyan Khairi** — 5026241053
2. **Yustisio Priyatno** — 5026241104
3. **Claudio Huge Siburian** — 5026241112
4. **Rafi Bartie Putra Nayar** — 5026241178
5. **Athallah Hilman Hilalazka** — 5026241145
6. **Muhammad Ajie Aditya Pratama** — 5026241172
7. **Faiz Abdulhaq** — 5026241030

---
### Cara menjalankan
```bash
flutter pub get
flutter run -d chrome
```
Jika berhasil, muncul tulisan **"Terhubung ke Supabase"**.

### Tabel database
| Tabel | Kolom utama |
|---|---|
| `pengguna` | id_pengguna (uuid = akun auth), nama, nrp, id_departemen, email, no_whatsapp |
| `departemen` | id_departemen, nama_departemen |
| `laporan_ktm` | id_laporan, id_pengguna, jenis (`hilang`/`ditemukan`), status (`aktif`/`selesai`), nama_pemilik_ktm, nrp_pemilik_ktm, id_departemen_pemilik, tanggal, lokasi, lokasi_dititipkan, keterangan, foto |
| `langkah_panduan` | nomor_langkah, deskripsi |
| `progres_panduan` | id_progres, id_pengguna, nomor_langkah, sudah_selesai, tanggal_selesai |

Baris `pengguna` dibuat otomatis oleh trigger `on_auth_user_created`
(`handle_new_user`) saat user mendaftar.
