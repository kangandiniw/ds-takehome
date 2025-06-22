# ds-takehome

## Data Scientist Test – SQL, Python, R


## Struktur Folder
├── data/
│ ├── e_commerce_transactions.csv
│ └── credit_scoring.csv
├── notebooks/
│ └── B_modeling.ipynb
│ └── decision_slide.pdf
│ └── shap_top10.png
├── analysis.sql # Bagian A: SQL Analytics
├── validation.R # Bagian C: R Statistical Check
├── A_findings.md # Insight dan temuan dari SQL analysis
├── C_summary.md # Ringkasan validasi model di R
├── calibration_curve.png # Gambar Calibration curve
└── README.md # Panduan eksekusi proyek



## Bagian A – SQL Analytics
📄 File: analysis.sql

Berisi query untuk:
Perhitungan RFM dan segmentasi pelanggan
Deteksi anomali berdasarkan decoy_noise
Analisis repeat purchase bulanan dengan EXPLAIN ANALYZE

Langkah:
Impor e_commerce_transactions.csv ke PostgreSQL → jalankan analysis.sql di pgAdmin.

## Bagian B – Modeling (Python)
📄 File: B_modeling.ipynb

Meliputi:
EDA & preprocessing
Modeling (Logistic Regression, Gradient Boosting)
Skoring (300–850) dan interpretasi SHAP

Output: decision_slide.pdf, shap_top10.png, scoring_result.csv

## Bagian C – Validasi Statistik (R)
📄 File: validation.R

Meliputi:
Uji Hosmer–Lemeshow (glmtoolbox)
Kalibrasi model (ggplot2)
Penentuan cut-off skor untuk expected default ≤ 5%

Output: calibration_curve.png, C_summary.md

