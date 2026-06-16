# Olist E-Commerce Sales Analysis

An end-to-end data analysis project on 99,441 real Brazilian e-commerce orders 
from Olist — Brazil's largest online marketplace.

## Live Dashboard
🔗 [View Interactive Tableau Dashboard](https://public.tableau.com/views/OlistE-CommerceAnalysisSreekarKoduru/Dashboard1)

---

## Project Summary
Analysed 2 years of e-commerce data (Sept 2016 – Oct 2018) to identify revenue 
trends, delivery performance gaps, and customer satisfaction drivers.

**Tools used:** Python · SQL (MySQL) · Tableau Public · Jupyter Notebook

---

## Key Findings

### 1. Revenue grew 6x in 2017 with a clear seasonal peak
Monthly revenue grew from R$127K in January 2017 to R$750K by October 2017.
November 2017 hit the peak at R$1.15M — driven by Black Friday/Cyber Monday.
Revenue plateaued around R$1.1M/month throughout 2018.

**Business implication:** Olist should plan inventory and logistics capacity 
increases ahead of November each year to capitalise on the seasonal spike.

### 2. 75% of Brazilian states experience above-average delivery times
São Paulo achieves 8.3 days average delivery. 18 out of 24 states exceed 
the 15-day threshold, with Amazonas worst at 26 days. Root cause is geographic 
— northern states have limited road infrastructure and are far from seller hubs.

**Business implication:** Incentivising seller expansion in northern and 
northeastern states would reduce last-mile delivery distance and directly 
improve customer satisfaction.

### 3. Delivery speed is the #1 driver of customer satisfaction
Orders delivered in ≤7 days average 4.41/5 stars.
Orders taking >21 days average only 3.01/5 stars — a 1.4 point drop.
57.8% of all reviews are 5 stars, but 11.5% are 1 star — a polarised 
customer base where delivery experience is the deciding factor.

**Business implication:** Every day added to delivery time measurably reduces 
satisfaction. Reducing average delivery from 12 to 8 days could shift a 
significant portion of 1-star reviews to 4-5 stars.

---

## Dashboard Preview
![Olist Performance Dashboard](dashboard/olist_dashboard_screenshot.png)

---

## Project Structure
```
project1-ecommerce-analysis/
├── data/                          # Raw CSV files (9 datasets)
├── notebooks/
│   └── ecommerce_analysis.ipynb  # Full analysis with charts
├── sql/
│   ├── query1_monthly_revenue.sql
│   ├── query2_top_categories.sql
│   ├── query3_delivery_by_state.sql
│   ├── query4_satisfaction_vs_delivery.sql
│   └── query5_seller_performance.sql
└── dashboard/
    ├── monthly_revenue_trend.png
    ├── top_categories_revenue.png
    ├── delivery_by_state.png
    └── customer_satisfaction.png
```

---

## SQL Highlights

**Monthly Revenue Trend:**
```sql
SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS `year_month`,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY `year_month`
ORDER BY `year_month` ASC;
```

---

## Dataset
- **Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **Size:** 99,441 orders · 9 CSV files · 2 years of data
- **Note:** Data is publicly available on Kaggle

---

## Author
**Sreekar Koduru**  
Data & Business Analyst | Python · SQL · Tableau | Canadian MSc  
[LinkedIn](https://www.linkedin.com/in/sreekar-koduru) · [GitHub](https://github.com/Sreekar-k12) · [Tableau Public](https://public.tableau.com/views/OlistE-CommerceAnalysisSreekarKoduru/Dashboard1)