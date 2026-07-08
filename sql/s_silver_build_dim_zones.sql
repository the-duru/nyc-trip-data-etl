-- Tekrarlayan bölgeleri (Zone) temizleyip benzersiz bir DIM_ZONE tablosu oluşturur
CREATE OR REPLACE TABLE silver.dim_zones AS
SELECT DISTINCT
    LocationID AS zone_id,
    Borough AS sehir_bolgesi,
    Zone AS mahalle_adi
FROM bronze.raw_green_taxis
WHERE LocationID IS NOT NULL;
