# Seattle Airbnb SQL Capstone Project
![](https://github.com/Thomas-Nyanumba/Seattle-Airbnb-Project/blob/main/Seattle%20Airbnb.png)
## Introduction 
This project [link](https://github.com/Thomas-Nyanumba/Seattle-Airbnb-Project/blob/main/ProjectSQLCode.sql) represents a detailed SQL analysis of Airbnb listings in Seattle, conducted as part of the **Analytics Extra Data Analytics Mentorship Program.** The analysis explores various aspects of the Airbnb market, including pricing trends, host revenue, guest sentiment, and seasonal trends. This project demonstrates my proficiency in SQL through data cleaning, transformation, aggregation, and insightful analysis.
## Problem Statement
This analysis addressed the following business questions:
1. Which neighborhood generates the highest total revenue, and what is the average listing price?
2. How do average listing prices vary across neighborhoods?
3. How frequently does the word "comfortable" appear in guest reviews?
4. Which listings have a high proportion of positive reviews?
5. How much revenue did each host generate from listings reviewed within the past year?
6. How many hosts are named "Stan" (case-insensitive)?
7. What is the total revenue from listings priced above $700?
8. Which listing has the highest number of reviews?
9. Which listings were last reviewed in the final quarter of 2022?
10. How can listings be categorized as "high-priced" or "low-priced" based on neighborhood averages?
## Skills and Concepts Demonstrated
- **SQL Joins**: Inner, Left joins to combine data from multiple tables.
- **Data Cleaning**: Type conversion, NULL value handling, and filtering.
- **Data Aggregation and Filtering**: SUM, AVG, COUNT, and `WHERE` clauses.
- **Conditional Logic**: Using `CASE` statements for categorization.
- **Window Functions and CTEs**: Using `ROW_NUMBER()` and `WITH` clauses.
## Data Overview
The dataset consists of three tables:
1. **Listings**: Contains unique listing details, including location and pricing.
2. **Pricing**: Captures pricing and availability data over time.
3. **Reviews**: Stores guest reviews, ratings, and feedback for each listing.
## Results and Analysis

### 1. Neighborhood with the Highest Revenue and Average Price
This query identifies the neighborhood with the highest total revenue and the average listing price.
```sql
SELECT TOP 1
    l.neighbourhood,
    SUM(p.price) AS total_revenue,
    AVG(p.price) AS avg_price_per_listing
FROM listings l
JOIN pricing p ON l.id = p.listing_id
GROUP BY l.neighbourhood
ORDER BY total_revenue DESC;
