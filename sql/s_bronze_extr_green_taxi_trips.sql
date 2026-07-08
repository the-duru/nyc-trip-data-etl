-- Yeşil taksi ham verilerini (JSON veya CSV'den) hiç dokunmadan okuyup Bronz şemasına yazar
CREATE OR REPLACE TABLE bronze.raw_green_taxis AS 
SELECT * FROM read_csv_auto('https://github.com/datasets/nyc-tlc-trips/raw/master/data/green_trips.csv');
