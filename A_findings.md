2. Deteksi Anomali dari Kolom decoy_noise (<=150 kata)
============================================================================
Berdasarkan hasil analisis statistik terhadap kolom decoy_noise, saya mengidentifikasi dua jenis anomali yang dapat memengaruhi validitas hasil analisis dan pemodelan data apabila tidak ditangani secara tepat.

Outlier ekstrem (nilai sangat tinggi):
Nilai 1468.46 terdeteksi sebagai outlier karena secara signifikan melebihi batas atas dari rentang interkuartil (IQR), yaitu 533.18. Nilai ini menunjukkan deviasi tajam dari pola distribusi umum dan besar kemungkinan merupakan hasil kesalahan input, noise sintetis, atau data yang tidak mencerminkan kondisi nyata.

Outlier frekuensi rendah (nilai sangat rendah):
Beberapa nilai seperti -48.34, -46.12, dan -35.19 hanya muncul satu kali dalam dataset dan berada jauh di bawah kuartil pertama (Q1 = 96.42). Nilai-nilai ini tidak masuk akal secara kontekstual dan berpotensi menyebabkan distorsi dalam proses pemodelan statistik atau machine learning.

Oleh karena itu, saya merekomendasikan untuk mengecualikan kedua jenis anomali ini selama tahap praproses data.