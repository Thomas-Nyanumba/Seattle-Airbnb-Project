
Create Database Airbnbcasestudy

USE Airbnbcasestudy

--Creating a table
CREATE TABLE airbnb_listings (
   id NUMERIC(20, 0),
    name VARCHAR(255),
    host_id INT,
    host_name VARCHAR(255),
    neighbourhood_group VARCHAR(255),
    neighbourhood VARCHAR(255),
    latitude DECIMAL(12, 8),
    longitude DECIMAL(12, 8),
    room_type VARCHAR(255),
    price INT,
    minimum_nights INT,
    number_of_reviews INT,
    last_review DATE,
    reviews_per_month DECIMAL(10, 2),
    calculated_host_listings_count INT,
    availability_365 INT,
    number_of_reviews_ltm INT,
    license VARCHAR(255)
);

--Querying the data 
SELECT *  FROM airbnb_listings

--Importing the Data
BULK INSERT airbnb_listings
FROM 'C:\Getting Started with SQL Course\listings.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,           -- Skip the header row (starts importing from row 2)
    FORMAT = 'CSV'          -- Specify that the input file is in CSV format
);

---creating pricing table
CREATE TABLE airbnb_pricing (
    listing_id INT,
    date DATE,
    available VARCHAR(10),
    price DECIMAL(10, 2),
    adjusted_price DECIMAL(10, 2),
    minimum_nights INT,
    maximum_nights INT,
    PRIMARY KEY (listing_id, date)
);

BULK INSERT airbnb_pricing
FROM 'C:\Getting Started with SQL Course\pricing.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter
    ROWTERMINATOR = '\n',   -- Specify the row terminator
    FIRSTROW = 2,           -- Skip the header row (starts importing from row 2)
    FORMAT = 'CSV'          -- Specify that the input file is in CSV format
);

SELECT * FROM airbnb_pricing


--Creating Reviews table
CREATE TABLE airbnb_reviews (
    listing_id BIGINT,
    id BIGINT,
    date DATE,
    reviewer_id INT,
    reviewer_name VARCHAR(255),
    comments TEXT
);

SELECT * FROM airbnb_reviews

BULK INSERT airbnb_reviews
FROM 'C:\Getting Started with SQL Course\reviews.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Specify the delimiter (comma)
    ROWTERMINATOR = '\n',   -- Specify the row terminator (newline)
    FIRSTROW = 2,           -- Skip the header row (starts importing from row 2)
    FORMAT = 'CSV'          -- Specify that the input file is in CSV format
);

