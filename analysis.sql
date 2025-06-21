-- 1. RFM Analysis + Segmentasi Pelanggan (>= 6)
-- ============================================================================
-- Tujuan:
-- Menghitung Recency, Frequency, Monetary untuk masing-masing customer
-- Membentuk segmentasi berbasis kuartil.

WITH rfm_base AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_order_date,
        COUNT(*) AS frequency,
        SUM(payment_value) AS monetary
    FROM e_commerce_transactions
    GROUP BY customer_id
), -- Hitung recency dari tanggal paling akhir di dataset
recency_calc AS (
    SELECT
        customer_id,
        frequency,
        monetary,
        (SELECT MAX(order_date) FROM e_commerce_transactions) - last_order_date AS recency
    FROM rfm_base
),
segment_kuartil AS ( -- Hitung Segmentasi Pelanggan Berdasarkan RFM
    SELECT *,
        NTILE(4) OVER (ORDER BY recency DESC) AS recency_segment,
        NTILE(4) OVER (ORDER BY frequency) AS frequency_segment,
        NTILE(4) OVER (ORDER BY monetary) AS monetary_segment
    FROM recency_calc
)
SELECT *, -- Menunjukkan hasil implementasi 6 Segmen Pelanggan
    CASE
        WHEN recency_segment = 1 AND frequency_segment >= 3 AND monetary_segment >= 3 THEN 'Loyal Customer'
        WHEN recency_segment = 4 AND frequency_segment <= 2 AND monetary_segment <= 2 THEN 'Lost Customer'
        WHEN recency_segment = 2 AND frequency_segment = 2 AND monetary_segment >= 3 THEN 'Big Spenders'
        WHEN recency_segment <= 2 AND frequency_segment <= 2 AND monetary_segment <= 2 THEN 'New Customer'
        WHEN recency_segment = 2 AND frequency_segment >= 3 AND monetary_segment = 2 THEN 'Potential Loyalist'
        WHEN recency_segment >= 3 AND frequency_segment >= 3 AND monetary_segment >= 3 THEN 'At Risk'
        ELSE 'Others'
    END AS customer_segment
FROM segment_kuartil;



















