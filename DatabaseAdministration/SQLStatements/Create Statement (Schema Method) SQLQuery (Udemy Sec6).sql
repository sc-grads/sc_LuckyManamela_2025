--Creating a table in the AdventureWorks DB using The Schema method

CREATE TABLE [AdventureWorks2016].[Sales].[StoreNew](
Store_ID INT NOT NULL,
Sales INT)
GO


--Altering the table StoreNew so that i can make Store_ID a primary key 
ALTER TABLE [AdventureWorks2016].[Sales].[StoreNew]
ADD CONSTRAINT PK_StoreNew PRIMARY KEY (Store_ID);
GO

--Creating a table named Visits on the Schema Sales and linking it to the StoreNew table
CREATE TABLE [AdventureWorks2016].[Sales].[Visits](
Visit_ID INT PRIMARY KEY IDENTITY(1,1),
First_Name VARCHAR(50) NOT NULL,
Last_Name VARCHAR(50) NOT NULL,
Visit_Date DATETIME,
Phone VARCHAR(20),
Store_ID INT NOT NULL,
FOREIGN KEY (Store_ID) REFERENCES Sales.StoreNew (Store_ID)
)

SELECT * FROM [AdventureWorks2016].[Sales].[Visits];