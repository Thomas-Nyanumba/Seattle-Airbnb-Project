-- Creating the database
CREATE DATABASE Seattle_Airbnb_Project

USE Seattle_Airbnb_Project

-- Creating the 3 dataset tables
CREATE TABLE listings( 
id NUMERIC(20, 0),
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
FROM 'C:\Users\user\Desktop\My Projects\Getting Started with SQL Course\listings.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,           -- Skip the header row (starts importing from row 2)
    FORMAT = 'CSV'          -- Specify that the input file is in CSV format
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
);

SELECT *FROM pricing

BULK INSERT pricing
FROM 'C:\Users\user\Desktop\My Projects\Getting Started with SQL Course\pricing.csv'
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

