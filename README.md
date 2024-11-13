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

**Result:** The neighborhood with the highest revenue and average price highlights areas of high demand.

### 2. Average Listing Price by Neighbourhood
Here, I compare the average price of listings across neighborhoods to identify pricing trends.

**Result:** Some neighborhoods have significantly higher average prices, indicating potential for premium markets. 

### 3. Count of "Comfortable" in Reviews
This query counts the occurrences of the word **comfortable** in the reviews.

**Result:** The count shows guest sentiment trends based on commonly used terms.

### 4. Listings with High Proportion of Positive Reviews
I filtered listings with positive review keywords (**great**, **comfortable**, **good**) to identify highly rated properties.

**Result:** Identifies listings that maintain a high ratio of positive feedback.

### 5. Revenue by Host for Recent Reviews
Calculated revenue from listings reviewed in the last year to understand recent host performance.

**Result:** Lists hosts with notable recent revenue performance.

### 6. Hosts Named "Stan"
I performed a case-insensitive search to find hosts named **Stan.**

**Result:** Provides a count of hosts named Stan, useful for networking or demographic analysis.

### 7. Total Revenue from High-Priced Listings
Revenue generated by listings priced above $700 helps identify high-value properties.

**Result:** Shows the revenue impact of high-priced listings.

### 8. Most Reviewed Listing
This query finds the listing with the highest review count.

**Result:** Highlights the most popular listing based on review volume.

### 9. Listings Reviewed in Q4 2022
Finds listings with reviews from October to December 2022, focusing on recent performance.

**Result:** Provides data on recent listings’ review activity.

### 10. Categorization of Listings as High- or Low-Priced
Using a neighborhood average, I categorized listings into "high-priced" or "low-priced."

**Result:** Shows the categorization of listings and highlights the potential pricing strategy.

## Conclusion 
This analysis offers insights into Seattle's Airbnb market by examining revenue, pricing, guest sentiment, and listing performance. These findings provide Airbnb hosts with actionable insights for optimizing pricing and improving guest experience.

## Recommendations 
1. Dynamic Pricing: Adjust prices seasonally to match occupancy patterns.
2. Customer Satisfaction: Encourage positive feedback by enhancing amenities.
3. Targeted Marketing: Promote high-rated and high-priced listings in premium areas.
