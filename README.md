# NYC Taxi Data ETL Pipeline

Bu proje, Henkan platformunun çok katmanlı veri işleme standartlarını ve **Medallion Architecture (Madalyon Mimarisi)** yapısını lokal ortamda simüle etmek amacıyla geliştirilmiştir. New York şehri taksi yolculuk verileri (Green & Yellow Taxi) kaynak sistemlerden ekstrakte edilerek DuckDB üzerinde katmanlı mimariye uygun şekilde modellenmiştir.

## 🧠 Transkript Teorisi & Proje Somutlaştırma Eşleşmesi

Eğitim videosunda anlatılan teorik kavramların bu projede koda dökülmüş somut karşılıkları şu şekildedir:

| Videodaki Anlatım / İfade | Projedeki Teknik Somutlaştırma |
| :--- | :--- |
| **"ETL main'in içerisinde... bronz, gold, silver olmak üzere buradaki katmanlar var."** | Proje mimarisi `bronze.subflow` ve `silver.subflow` olarak iki ana katmana bölünmüştür. Veri ham (Bronze) ve işlenmiş/modellenmiş (Silver) olarak ayrıştırılmıştır. |
| **"Bu bir parameter bu duck-db... Hesaplama motoru altyapısı."** | Projede veri ambarı altyapısı ve SQL dönüşümlerinin compute gücü olarak `target: duckdb` konfigürasyonu tanımlanmıştır. |
| **"Her biten cabın ardından ok'un gösterdiği cab çalışmaya devam edecek."** | `silver.subflow` içinde `dependsOn` mimarisi kullanılmıştır. Sabit bölge verilerini tutan **Dimension (DIM)** tablosu (`build-dim-zones`) bitmeden, hareket verilerini hesaplayan **Fact (FACT)** tablosunun (`build-fact-trips`) çalışmaması kuralı kodla kurgulanmıştır. |

## 🛠️ Katmanlı Mimari Yapısı

*   **Bronze Katmanı (`bronze.subflow`):** Ham taksi verileri internet üzerindeki kaynaklardan hiçbir manipülasyona uğramadan `type: extract` job türüyle DuckDB içerisine alınmıştır.
*   **Silver Katmanı (`silver.subflow`):** Temizlenen veriler veri ambarı standartlarında ikiye modellenmiştir:
    *   **Dimension (DIM):** `s_silver_build_dim_zones.sql` ile taksi bölge bilgileri tutulur.
    *   **Fact (FACT):** `s_silver_build_fact_trips.sql` ile sürüş hareketleri ve sayısal ciro metrikleri hesaplanır.
