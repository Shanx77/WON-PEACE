create database WONPEACE;
USE WONPEACE;

CREATE TABLE Customer1(
	Cust_ID varchar(20) PRIMARY KEY,
	Fname varchar(10),
	Lname varchar(10),
	Email varchar(10),
	Phone int,
	Gender char,
	Username varchar(20),
	pass varchar(18)
);

CREATE TABLE Allergies(
	Allergy_ID varchar(20),
	Medical_ID varchar(20),
	Medical_Cond varchar(20),
	Allergies varchar(20),
	Cust_ID varchar(20),
	Primary key (Allergy_ID, Medical_ID),
	foreign key (Cust_ID) references Customer1(Cust_ID)
);

CREATE TABLE Customer2(
	 Calorie_ID varchar(20),
	 Diet_ID varchar(20),
	 Age int,
	 Weights int,
	 Height int,
	 Ideal_weight int,
	 Calories_Needed float,
	 Allergy_ID varchar(20),
	 Medical_ID varchar(20),
	 Cust_ID varchar(20),
	 primary key (Calorie_ID, Diet_ID),
	 foreign key (Allergy_ID,Medical_ID) references Allergies(Allergy_ID,Medical_ID),
	 foreign key (Cust_ID) references Customer1(Cust_ID)
);

CREATE TABLE Food (
    Food_ID varchar(20) PRIMARY KEY,
    Food_Name varchar(100),
    Servings varchar(100),
    Times varchar(100),
    Calorie_per_100g int,
	Calorie_ID varchar(20),
	Diet_ID varchar(20),
	Common_Food varchar(100),
	foreign key (Calorie_ID, Diet_ID) references Customer2(Calorie_ID,Diet_ID)
);

CREATE TABLE Diet_Plan(
	Food varchar(100),
	Calorie float,
	Serving Int,
	Times varchar(20),
	Calorie_ID varchar(20),
	Diet_ID varchar(20),
	Food_ID varchar(20),
	foreign key (Calorie_ID, Diet_ID) references Customer2(Calorie_ID,Diet_ID),
	foreign key (Food_ID) references Food (Food_ID)
);

CREATE TABLE Common_Food(
	Comfood_ID Varchar(20),
	Nutrients varchar(1000),
	Servings varchar(1000),
	Food_Name varchar(20)
);

ALTER TABLE Customer2
ADD Gender Char;

ALTER TABLE Customer1
DROP COLUMN Gender;

ALTER TABLE Customer2
DROP COLUMN Ideal_weight;

SELECT name, schema_id, create_date
FROM sys.tables
WHERE schema_id = USER_ID() AND name NOT LIKE 'spt_%' AND name NOT LIKE 'Msreplication%';
*****************************************************************************************************************************************************************************************
SELECT
   Weights,
   Height,
   Age,
   Gender,
   CASE Gender
      WHEN 'M' THEN 66 + (6.23*2.2*Weights) + (12.7*12*Height)-(6.8*Age)
      WHEN 'F' THEN 655 + (4.35*2.2*Weights) + (4.7*12*Height)-(4.7*Age)
      ELSE NULL
   END AS Calorie_Needed
FROM Customer2;



SELECT Food.Food_Name, Food.Servings, Food.Calorie_per_100g, Food.Times
FROM Food
JOIN Customer2 c ON Food.Calorie_ID = c.Calorie_ID AND Food.Diet_ID = c.Diet_ID
JOIN Allergies a ON c.Allergy_ID = a.Allergy_ID AND c.Medical_ID = a.Medical_ID
WHERE c.Calorie_ID > 1800 AND a.Medical_ID = 'M' AND a.Allergy_ID = 'A';
******************************************************************************************************************************************************************************************