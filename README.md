

1. widget tree di flutter itu kayak struktur pohon yang nunjukin hubungan antar widget dari atas ke bawah.
   setiap widget bisa punya satu atau beberapa widget anak di dalamnya, dan posisi mereka diatur berdasarkan parent-nya.
   misalnya di aplikasi ini, materialapp ada di paling atas, lalu di dalamnya ada scaffold, di dalam scaffold ada appbar dan body, dan di dalam body ada column yang berisi row, text, dan gridview.
   kalau parent dihapus, widget anaknya juga bakal ikut hilang karena dia bergantung sama parent-nya.

2.  widget yang aku pakai di proyek ini antara lain materialapp buat kerangka utama aplikasi, scaffold buat struktur dasar halaman,
    appbar buat judul di bagian atas, padding buat ngasih jarak antar elemen, column buat nyusun widget secara vertikal, row buat nyusun widget secara horizontal,
    card buat nampilin info seperti nama, npm, dan kelas, text buat teks, gridview.count buat nampilin tombol-tombol dalam bentuk grid,
    material buat efek tampilan material design, inkwell buat deteksi sentuhan, icon buat nampilin ikon di tombol, dan snackbar buat munculin notifikasi waktu tombol ditekan.

3. widget materialapp berfungsi sebagai wadah utama aplikasi yang berbasis material design. dia ngatur tema warna, navigasi halaman, dan judul aplikasi.
   widget ini sering dipakai sebagai root karena semua widget di bawahnya bakal ikut gaya dan pengaturan dari materialapp.

4. perbedaan antara statelesswidget dan statefulwidget adalah pada kemampuannya berubah. statelesswidget bersifat statis dan gak bisa berubah selama aplikasi berjalan,
   cocok buat tampilan yang gak butuh update kayak teks atau ikon. sedangkan statefulwidget bisa berubah sesuai interaksi pengguna atau data,
   cocok buat fitur yang dinamis seperti form atau list yang bisa diperbarui. di tugas ini aku pakai statelesswidget karena tampilannya masih statis.

5. buildcontext adalah objek yang nyimpen informasi tentang posisi widget di dalam widget tree. dia penting karena dipakai buat ngakses data atau fitur yang ada di atasnya,
   seperti tema, navigator, atau snackbar. contohnya, waktu munculin snackbar, kita butuh scaffoldmessenger.of(context) biar snackbar-nya muncul di halaman yang tepat.

6. konsep hot reload di flutter memungkinkan kita ngelihat perubahan kode secara langsung tanpa harus ngulang aplikasi dari awal. ini berguna buat ubah tampilan, warna, atau teks dengan cepat.
   sementara itu, hot restart bakal merestart seluruh aplikasi dan ngulang semua state dari awal, cocok kalau ada perubahan besar yang gak bisa ditangani hot reload.

7. navigator.push() nambah halaman baru di atas halaman sekarang, jadi bisa balik ke halaman sebelumnya.
navigator.pushreplacement() ganti halaman sekarang dengan yang baru, jadi ga bisa balik.
push() dipakai buat navigasi sementara (misal liat detail produk), sedangkan pushreplacement() dipakai buat pindah dari home ke form biar ga numpuk di stack.

8. scaffold jadi kerangka utama halaman, appbar buat judul dan identitas aplikasi, dan drawer buat navigasi antarhalaman. semua halaman pakai struktur ini biar tampilannya konsisten dan navigasinya gampang.

9. padding bikin jarak antar-elemen biar rapi,
singlechildscrollview biar form bisa discroll kalau panjang,
listview biar semua elemen form tersusun vertikal dan fleksibel.
contohnya di form tambah produk kickback, semua input dibungkus listview biar bisa discroll.

10. warna tema diset lewat colorscheme di materialapp.
kickback pakai warna biru dan indigo biar keliatan modern dan sesuai nuansa toko olahraga.
warna ini juga dipakai di appbar dan tombol biar konsisten.