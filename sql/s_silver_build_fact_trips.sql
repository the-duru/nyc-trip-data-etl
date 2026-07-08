-- Tüm taksi yolculuklarını birleştirir, tutarları hesaplar ve FACT tablosunu kurar
CREATE OR REPLACE TABLE silver.fact_trips AS
SELECT 
    y.VendorID AS satici_id,
    y.tpep_pickup_datetime AS biniş_zamani,
    y.passenger_count AS yolcu_sayisi,
    y.trip_distance AS yolculuk_mesafesi,
    y.fare_amount AS yalın_ucret,
    (y.fare_amount + y.tip_amount) AS toplam_odenen_tutar -- Fact Metriği
FROM bronze.raw_yellow_taxis y
-- Sadece geçerli lokasyonlardaki (DIM tablosunda olan) sürüşleri kabul ediyoruz
INNER JOIN silver.dim_zones z ON y.RatecodeID = z.zone_id;
