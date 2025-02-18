ALTER DATABASE Sambe_Graduates2025
REMOVE FILE Sambe_Graduates2025NewDataFile--Removing the file  

ALTER DATABASE Sambe_Graduates2025
REMOVE FILEGROUP secondary

USE master
GO
EXEC sp_detach_db "Sambe_Graduates2025" -- detaching the database
GO
DROP DATABASE Sambe_Graduates2025