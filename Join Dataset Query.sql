
---- UNDERSTANDING JOINS IN SQL
--Create Training Performance Table

--Create Training Performance Table
CREATE TABLE Training_Performance (
Student_Name VARCHAR(50),
Email VARCHAR(50),
Assimilation_Score INT,
Performance INT
)

--Insert Data into Training Performance
INSERT INTO Training_Performance
VALUES('Adewale Yusuf','adewale@gmail.com',30,20),
        ('Joe Biden','joe@gmail.com',49,75),
        ('Akin Shola','akin@gmail.com',51,65),
        ('David White','david@gmail.com',53,50),
        ('Dara Snow','dara@gmail.com',46,20)


---Create Employee Details Table
CREATE TABLE Employee_Details (
Employee_Name VARCHAR(50),
Email VARCHAR(50),
Department VARCHAR(50),
Age INT,
Job_Title VARCHAR(50)
)

--Insert Data into Employee Details
INSERT INTO Employee_Details
VALUES('Adewale Yusuf','adewale@gmail.com','Sales',20,'Sales Analyst'),
        ('Joe Biden','joe@gmail.com','HR',34,'Office Admin'),
        ('Akin Shola','akin@gmail.com','IT',42,'Technical Analyst'),
        ('David White','david@gmail.com','Sales',26,'Sales Rep'),
        ('Michelle Sarah','michelle@gmail.com','HR',45,'Head of HR'),
        ('Sean Josh','sean@gmail.com','IT',30,'CTO')


SELECT *
FROM Training_Performance

SELECT *
FROM Employee_Details