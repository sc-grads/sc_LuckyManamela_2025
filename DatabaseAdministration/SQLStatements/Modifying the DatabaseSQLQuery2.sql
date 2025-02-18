ALTER DATABASE Sambe_Graduates2025
ADD FILEGROUP secondary

ALTER DATABASE Sambe_Graduates2025
ADD FILE -- adding file 
(
NAME = Sambe_Graduates2025NewDataFile,
FILENAME = 'C:\Mydatbase\Sambe_Graduates2025NewDataFile.ndf',
SIZE = 10, -- setting the initial size to 10mb
MAXSIZE = 100, --Limits the maximum size of the file to 100 MB
FILEGROWTH = 5 /*Specifies that the file will grow in increments of 5 MB whenever it runs out of space.
Instead of setting a fixed size, SQL Server automatically expands the file as needed.*/)

