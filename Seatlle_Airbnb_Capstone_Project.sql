-- Creating the database
CREATE DATABASE Seattle_Airbnb_Project

USE Seattle_Airbnb_Project

-- Creating the 3 dataset tables
CREATE TABLE listings( 
id NUMERIC(20, 0) PRIMARY KEY,
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
	PRIMARY KEY (listing_id, date)
	FOREIGN KEY (listing_id), REFERENCES listings(id)
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

--EXEC sp_configure 'show advanced options', 1;
--RECONFIGURE;
--EXEC sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;

CREATE TABLE reviews (
    listing_id BIGINT,      -- Corrected data type
    ID BIGINT PRIMARY KEY,
    date DATE,
    reviewer_id VARCHAR(200),
    reviewer_name VARCHAR(70),
    comments TEXT
	FOREIGN KEY (listing_id) REFERENCES listing(id)
);

-- Perform bulk insert into the reviews table
BULK INSERT reviews
FROM 'C:\Users\USER\Desktop\My Projects\Getting Started with SQL Course\reviews.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,            -- Skip the header row (starts importing from row 2)
	FORMAT = 'CSV'
);



CREATE TABLE reviews_staging (
    listing_id BIGINT,
    ID BIGINT PRIMARY KEY,
    date VARCHAR(255),
    reviewer_id INT PRIMARY KEY,
    reviewer_name VARCHAR(70),
    comments TEXT
	FOREIGN KEY (listing_id) REFERENCES listing(id)
);

BULK INSERT reviews_staging
FROM 'C:\Users\USER\Desktop\My Projects\Getting Started with SQL Course\reviews.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);

INSERT INTO reviews (listing_id, ID, date, reviewer_id, reviewer_name, comments)
SELECT 
    TRY_CAST(listing_id AS BIGINT),
    TRY_CAST(ID AS BIGINT),
    TRY_CAST(date AS DATE),
    reviewer_id,
    reviewer_name,
    comments
FROM reviews_staging
WHERE TRY_CAST(listing_id AS BIGINT) IS NOT NULL 
  AND TRY_CAST(ID AS BIGINT) IS NOT NULL;


  SELECT *FROM reviews_staging

  
  SELECT 
    l.id AS listing_id,
    l.name,
    p.date AS pricing_date,
    p.price,
    r.date AS review_date,
    r.reviewer_name,
    r.comments
FROM 
    listings l
JOIN 
    pricing p ON l.id = p.listing_id  -- Join listings and pricing on listing_id
JOIN 
    reviews r ON l.id = r.listing_id  -- Join listings and reviews on listing_id
ORDER BY 
    l.id;  -- Optional: order by listing_id