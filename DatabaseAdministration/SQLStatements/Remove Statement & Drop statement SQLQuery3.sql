ALTER DATABASE Sambe_Graduates2025
REMOVE FILE Sambe_Graduates2025NewDataFile

ALTER DATABASE Sambe_Graduates2025
REMOVE FILEGROUP secondary

USE master
GO
EXEC sp_detach_db "Sambe_Graduates2025"
GO
DROP DATABASE Sambe_Graduates2025