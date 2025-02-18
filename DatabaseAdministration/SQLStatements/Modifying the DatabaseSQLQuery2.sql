ALTER DATABASE Sambe_Graduates2025
ADD FILEGROUP secondary

ALTER DATABASE Sambe_Graduates2025
ADD FILE
(
NAME = Sambe_Graduates2025NewDataFile,
FILENAME = 'C:\Mydatbase\Sambe_Graduates2025NewDataFile.ndf',
SIZE = 10,
MAXSIZE = 100,
FILEGROWTH = 5)

