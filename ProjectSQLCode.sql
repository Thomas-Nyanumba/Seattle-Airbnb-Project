-- Creating the database
CREATE DATABASE Seattle

USE Seattle

-- Creating the 3 dataset tables
CREATE TABLE listings ( 
id INT PRIMARY KEY,
    name VARCHAR(255),
    host_id INT,
    host_name VARCHAR(255),
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude DECIMAL(12, 2),
    longitude DECIMAL(12, 2),
    room_type VARCHAR(255),
    price NUMERIC (20, 2),
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month DECIMAL(10, 2),
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    license VARCHAR(255)
);

SELECT *FROM listings

--- Importing the 3 datasets
BULK INSERT listings
FROM 'C:\Users\USER\Desktop\My Projects\Getting Started with SQL Course\listings.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,          -- Skip the header row (starts importing from row 2)
	FORMAT = 'CSV'
);

CREATE TABLE pricing (
listing_id INT,
	date DATE,
	avaiable VARCHAR (10),
	price NUMERIC (20, 2),
	adjusted_price NUMERIC (20, 0),
	minimum_nights INT,
	maximum_nights INT,
	PRIMARY KEY (listing_id, date),
	FOREIGN KEY (listing_id) REFERENCES listings(id)
);



SELECT *FROM pricing

BULK INSERT pricing
FROM 'C:\Users\USER\Desktop\My Projects\Getting Started with SQL Course\pricing.csv'
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2,
	FORMAT = 'CSV'
	);


CREATE TABLE reviews_staging (
    listing_id VARCHAR (255),      
    ID VARCHAR (255),
    date VARCHAR (255),
    reviewer_id VARCHAR (255),
    reviewer_name VARCHAR(70),
    comments TEXT
);

-- Perform bulk insert into the reviews table
BULK INSERT reviews_staging
FROM 'C:\Users\USER\Desktop\My Projects\Getting Started with SQL Course\reviews.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,            -- Skip the header row (starts importing from row 2)
	FORMAT = 'CSV'
);

--Checking for data issues
SELECT *
FROM reviews_staging
WHERE TRY_CAST (listing_id AS BIGINT) IS NULL 
OR TRY_CAST (ID AS BIGINT) IS NULL


CREATE TABLE reviews (
    listing_id INT,               -- Matches data type for consistency with listings table
    ID BIGINT PRIMARY KEY,        -- Unique identifier for each review
    date DATE,
    reviewer_id INT,
    reviewer_name VARCHAR(70),
    comments TEXT,
    FOREIGN KEY (listing_id) REFERENCES listings(id) -- Links to listings table
);

INSERT INTO reviews (listing_id, ID, date, reviewer_id, reviewer_name, comments)
SELECT 
    TRY_CAST(listing_id AS INT),
    TRY_CAST(ID AS BIGINT),
    TRY_CAST(date AS DATE),
    TRY_CAST(reviewer_id AS INT),
    reviewer_name,
    comments
FROM reviews_staging
WHERE TRY_CAST(listing_id AS INT) IS NOT NULL 
  AND TRY_CAST(ID AS BIGINT) IS NOT NULL;

  SELECT * FROM reviews
  DROP TABLE reviews_staging


  --A left JOIN
  SELECT 
    l.id AS listing_id,
    l.name AS listing_name,
    l.host_name,
    l.neighbourhood,
    l.latitude,
    l.longitude,
    l.room_type,
    p.price,
    p.date AS pricing_date,
    r.date AS review_date,
    r.comments
FROM listings l
LEFT JOIN pricing p ON l.id = p.listing_id
LEFT JOIN reviews r ON l.id = r.listing_id
ORDER BY l.id;

-- Q1 Find the neighborhood with the highest total revenue and the average price per listing

SELECT TOP 1
    l.neighbourhood,
    SUM(p.price) AS total_revenue,
    AVG(p.price) AS avg_price_per_listing
FROM listings l
JOIN pricing p ON l.id = p.listing_id
GROUP BY l.neighbourhood
ORDER BY total_revenue DESC

-- Q2 Compare the average price of listings in different neighborhoods

SELECT 
    l.neighbourhood,
    AVG(p.price) AS avg_price
FROM listings l
JOIN pricing p ON l.id = p.listing_id
GROUP BY l.neighbourhood
ORDER BY avg_price DESC;

-- Q3 Count the occurrences of the word "comfortable" in the comment's column

SELECT 
    COUNT(*) AS comfortable_count
FROM reviews r
WHERE LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%comfortable%'; 

-- Q4 Identify listings with a high proportion of positive reviews (comments with “great”, “comfortable” and “good”)

SELECT 
    l.id AS listing_id,
    l.name AS listing_name,
    COUNT(r.ID) AS total_reviews,
    SUM(CASE WHEN LOWER (CAST(r.comments AS VARCHAR (MAX))) LIKE '%great%' 
	OR LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%comfortable%' 
	OR LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%good%' THEN 1 ELSE 0 END) AS positive_reviews

FROM listings l
JOIN reviews r ON l.id = r.listing_id
GROUP BY l.id, l.name
HAVING (SUM(CASE WHEN LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%great%' 
OR LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%comfortable%' 
OR LOWER(CAST(r.comments AS VARCHAR (MAX))) LIKE '%good%' THEN 1 ELSE 0 END) / COUNT(r.ID)) > 0.5;

-- Q5 Calculate the total revenue generated by each host for listings that were last reviewed within the past one year

SELECT 
    l.host_name,
    SUM(p.price) AS total_revenue
FROM listings l
JOIN pricing p ON l.id = p.listing_id
JOIN reviews r ON l.id = r.listing_id
WHERE r.date IS NOT NULL
AND r.date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY l.host_name;

-- Q6 Find hosts with the name ‘Stan’, regardless of capitalization

SELECT 
    DISTINCT l.host_name
FROM listings l
WHERE LOWER(l.host_name) = 'stan';

-- Q7 Calculate the total revenue generated by listings with a price above $700

SELECT 
    l.id AS listing_id,
    l.name AS listing_name,
    SUM(p.price) AS total_revenue
FROM listings l
JOIN pricing p ON l.id = p.listing_id
WHERE p.price > 700
GROUP BY l.id, l.name;

-- Q8 Find the most reviewed listing

SELECT TOP 1
    l.id AS listing_id,
    l.name AS listing_name,
    COUNT(r.ID) AS review_count
FROM listings l
JOIN reviews r ON l.id = r.listing_id
GROUP BY l.id, l.name
ORDER BY review_count DESC

-- Q9 Find listings that were last reviewed in the last quarter of 2022

SELECT 
    l.id AS listing_id,
    l.name AS listing_name,
    r.date AS last_review_date
FROM listings l
JOIN reviews r ON l.id = r.listing_id
WHERE r.date IS NOT NULL
AND r.date BETWEEN '2022-10-01' AND '2022-12-31';


-- Q10 Calculate the total revenue generated for each listing, categorizing them as "high-priced" or "low-priced" based on their price relative to the average price for their neighborhood

WITH neighborhood_avg AS (
    SELECT 
        neighbourhood,
        AVG(p.price) AS avg_neighborhood_price
    FROM listings l
    JOIN pricing p ON l.id = p.listing_id
    GROUP BY neighbourhood
)
SELECT 
    l.id AS listing_id,
    l.name AS listing_name,
    p.price,
    CASE 
        WHEN p.price > na.avg_neighborhood_price THEN 'high-priced'
        ELSE 'low-priced'
    END AS price_category,
    SUM(p.price) AS total_revenue
FROM listings l
JOIN pricing p ON l.id = p.listing_id
JOIN neighborhood_avg na ON l.neighbourhood = na.neighbourhood
GROUP BY l.id, p.price, na.avg_neighborhood_price, l.name;


