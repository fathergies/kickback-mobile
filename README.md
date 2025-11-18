

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

11. kita perlu bikin model dart karena dia jadi “kontrak data” antara flutter dan django. model ngejamin setiap field punya tipe yang jelas, mana yang nullable, dan bagaimana data json harus diparse. tanpa model, semua data masuk sebagai Map<String, dynamic> yang rawan typo, rawan error karena dynamic casting, dan bikin null-safety kacau. misalnya salah tulis key thumbnail jadi thumnail, compiler nggak bakal protes dan errornya baru muncul pas runtime. di project yang terus berkembang, model juga bantu maintainability karena struktur data terkumpul rapi di satu tempat dan gampang diupdate ketika backend berubah.

12. package http itu library umum buat kirim request ke server, tapi dia nggak otomatis ngurus cookie, session, atau authentikasi django. CookieRequest justru dibuat khusus di pbp biar flutter bisa login/logout ke django pake session, ngirim csrftoken kalau perlu, dan nge-handle cookie secara otomatis. jadi http itu low-level, sedangkan CookieRequest high-level dan nyediain fungsi yang siap pakai seperti login, logout, postJson, dan get. karena tugas ini butuh autentikasi django, CookieRequest yang jadi pintu utama komunikasi.

13. kita harus share satu instance CookieRequest ke seluruh aplikasi karena di situlah cookie session django disimpan. kalau tiap halaman bikin instance sendiri, maka session id-nya beda-beda dan django bakal nganggep user itu belum login. dengan naruh CookieRequest di Provider paling atas, seluruh halaman bisa akses session yang sama, cek status login, dan ngirim request ke django sebagai user yang sama. ini mencegah kejadian aneh kayak “halaman A login, halaman B malah dianggap guest”.

14. supaya flutter bisa komunikasi lancar sama django, ada beberapa konfigurasi penting. di emulator android, localhost nggak bisa langsung diakses sehingga harus pakai alamat khusus 10.0.2.2. supaya request ini diterima django, host tersebut harus dimasukin ke ALLOWED_HOSTS. untuk flutter web, request dianggap cross-origin sehingga django perlu CORS headers supaya browser nggak ngeblok permintaan. cookie session juga perlu konfigurasi samesite dan secure supaya bisa terkirim di environment tertentu. dan di android, aplikasi cuma boleh akses internet kalau sudah dikasih permission di AndroidManifest.xml. kalau salah satu langkah dilewatin, request bisa gagal total, cookie nggak ke-store, atau login keliatan sukses tapi session nggak pernah kebaca di request berikutnya.

15. alur pengiriman data dari form ke flutter itu cukup sistematis. user isi form di flutter, data dikumpulin dari controller lalu dikirim sebagai json lewat request.postJson. django nerima data tersebut, nge-parse body JSON, bikin model baru, lalu menyimpan ke database. django kemudian ngirim respon balik dalam bentuk json juga. flutter nerima respon itu, ngecek statusnya, terus kalau sukses biasanya melakukan refresh list atau ngearahkan user ke halaman lain. untuk menampilkan data, flutter melakukan GET ke endpoint json, parsing tiap item ke model dart (fromJson), dan kemudian disusun ke UI melalui widget seperti card atau detail page.

16. mekanisme autentikasi dimulai dari register: flutter kirim username dan password ke endpoint django, dan django memvalidasi serta menyimpan akun baru. ketika login, flutter ngirim username dan password lewat CookieRequest.login, lalu django memverifikasi dan mengembalikan cookie session. cookie ini disimpan di CookieRequest, sehingga setiap request berikutnya akan otomatis dianggap sebagai user yang sudah login. saat logout, flutter memanggil endpoint logout django, django menghapus session, dan CookieRequest menghapus cookie lokal. setelah itu flutter mengarahkan user kembali ke login page, memastikan tidak ada akses ke halaman yang perlu autentikasi.

17. implementasi checklist aku lakukan secara bertahap dari backend ke frontend. pertama aku pastiin seluruh endpoint django berjalan, termasuk json list, filter “my products”, endpoint detail, serta endpoint khusus create product dari flutter. setelah itu aku setup provider dan CookieRequest di flutter supaya session bisa dipakai global. berikutnya aku kerjain login dan register dengan styling yang konsisten. setelah autentikasi beres, aku bikin model dart custom untuk produk biar data parsing rapi dan stabil. lalu aku implementasikan halaman list produk dengan filter “all” dan “my”, kemudian halaman detail yang tampilannya disamain sama versi django. drawer juga aku tambahin menu navigasi dan tombol logout yang bener-bener hapus session. terakhir aku rapihin konektivitas, termasuk proxy-image, CORS, dan allowed hosts. jadi bukan cuma ikut tutorial, tapi aku bangun flow yang cocok sama struktur project kickback versi django.