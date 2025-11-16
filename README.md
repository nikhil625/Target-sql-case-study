# Target E-Commerce SQL Case Study

**Author:** Nikhil Mehalawat  
**Contact:** nikhilmehalawat@gmail.com

## Project Summary
This repository contains a full SQL-based case study on Brazilian e-commerce data (Target dataset) executed in **Google BigQuery**.
The analysis explores ordering trends, seasonality, delivery performance, freight economics, and payment behavior.

## Repository Structure
```
Target-SQL-Case-Study-FULL/
├── README.md
├── case_study.pdf
├── sql/
│   ├── 01_exploratory_analysis.sql
│   ├── 02_trend_seasonality.sql
│   ├── 03_state_wise_orders.sql
│   ├── 04_economic_impact.sql
│   ├── 05_delivery_analysis.sql
│   └── 06_payment_analysis.sql
├── results/
│   ├── monthly_orders_trend.png
│   ├── time_of_day_distribution.png
│   ├── delivery_time_histogram.png
│   └── freight_vs_delivery_scatter.png
└── data_dictionary/
    └── table_structure.txt
```

## Highlights / Key Findings (Executive Summary)
- **Seasonality:** Orders peak in November (likely holiday season).  
- **Time of Day:** Most orders are placed in the afternoon.  
- **Payments:** Credit Card is the dominant payment method; boleto is second.  
- **Logistics:** Freight cost and delivery delays are correlated — distant states pay more and wait longer.  
- **Recommendation:** Improve delivery estimates for slow states; negotiate freight rates or open regional hubs.

## How to Reproduce
1. Open Google BigQuery.
2. Point to the dataset `scaler-project-465604.Target` or import equivalent tables.
3. Run the SQL files in the `sql/` folder in order (01 → 06).
4. Results images in `results/` are illustrative; replace with actual exported charts if available.

## Skills Demonstrated
- SQL (window functions, aggregation, joins, date functions, CTE)
- BigQuery (standard SQL)
- EDA and data interpretation
- Reporting & documentation
