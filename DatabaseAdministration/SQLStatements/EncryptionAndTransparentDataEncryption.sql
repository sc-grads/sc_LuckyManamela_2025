--SQL Server Encryption and Transparent Data Encryption (TDE)
--Setting Up Transparent Data Encryption (TDE)

--Creating a Master Key in the master database
USE master;
GO
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'LuckyManamela@1991';
GO

--Creating a Certificate in the master database for TDE
CREATE CERTIFICATE TDECert
WITH SUBJECT = 'TDE Certificate';
GO

--Creating a Database Encryption Key in the target database using the certificate
USE AdventureWorks2016;
GO
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE TDECert;
GO

--Enable TDE on the database
ALTER DATABASE AdventureWorks2016
SET ENCRYPTION ON;
GO
