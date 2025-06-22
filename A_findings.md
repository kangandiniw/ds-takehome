2. Deteksi Anomali dari Kolom decoy_noise (<=150 kata)
============================================================================

Berdasarkan hasil analisis statistik terhadap kolom decoy_noise, saya mengidentifikasi dua jenis anomali yang dapat memengaruhi validitas hasil analisis dan pemodelan data apabila tidak ditangani secara tepat.

Outlier ekstrem (nilai sangat tinggi):
Nilai 1468.46 terdeteksi sebagai outlier karena secara signifikan melebihi batas atas dari rentang interkuartil (IQR), yaitu 533.18. Nilai ini menunjukkan deviasi tajam dari pola distribusi umum dan besar kemungkinan merupakan hasil kesalahan input, noise sintetis, atau data yang tidak mencerminkan kondisi nyata.

Outlier frekuensi rendah (nilai sangat rendah):
Beberapa nilai seperti -48.34, -46.12, dan -35.19 hanya muncul satu kali dalam dataset dan berada jauh di bawah kuartil pertama (Q1 = 96.42). Nilai-nilai ini tidak masuk akal secara kontekstual dan berpotensi menyebabkan distorsi dalam proses pemodelan statistik atau machine learning.

Oleh karena itu, saya merekomendasikan untuk mengecualikan kedua jenis anomali ini selama tahap praproses data.




3. Repeat Purchase Bulanan (Hasil Analisa)
============================================================================

Query ini bertujuan untuk mengidentifikasi pelanggan yang melakukan lebih dari satu transaksi dalam satu bulan. Berdasarkan hasil EXPLAIN ANALYZE, sistem melakukan pembacaan penuh terhadap tabel e_commerce_transactions melalui metode sequential scan, karena penggunaan fungsi date_trunc() menyebabkan index yang ada tidak dapat dimanfaatkan.

Meskipun demikian, dengan jumlah data sebesar 10.000 baris, waktu eksekusi tetap efisien, yaitu hanya 5,541 milidetik. Hasil agregasi menunjukkan bahwa terdapat 2.401 kombinasi customer dan bulan yang memenuhi kriteria (count > 1), sedangkan 1.887 kombinasi lainnya diabaikan karena hanya memiliki satu transaksi.

Untuk skala data yang lebih besar, disarankan menambahkan kolom tambahan seperti order_month dan membuat index yang sesuai, agar proses agregasi dan pemfilteran dapat berjalan lebih optimal.
