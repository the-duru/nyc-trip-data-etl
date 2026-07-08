-- Sarı taksi ham verilerini okuyup Bronz şemasına yazar
CREATE OR REPLACE TABLE bronze.raw_yellow_taxis AS 
SELECT * FROM read_csv_auto('https://github.com/datasets/nyc-tlc-trips/raw/master/data/yellow_trips.csv');
