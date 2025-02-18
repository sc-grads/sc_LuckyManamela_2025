CREATE DATABASE Sambe_Graduates2025 --creating a database named Sambe_Graduates2025

/*specifying the data files associated with the database*/
ON(

/* specifying the logical name of the data file. The logical name is used by SQL Server to identify the file within the database system.*/
	NAME = Sambe_Graduates2025DataFile, 
/*This specifies the physical location (path and file name) of the data file.
The .mdf extension is used for the primary data file (Master Data File) in SQL Server.*/
	FILENAME = 'C:\sc_LuckyManamela_2025\DatabaseAdministration\SQLStatements\Sambe_Graduates2025DataFile.mdf')

/*specifies the transaction log file associated with the database. 
The log file tracks all changes to the database and is essential for recovery, rollback, and ensuring data consistency.*/
	LOG ON (
	NAME = Sambe_Graduates2025LogFile,
	FILENAME = 'C:\sc_LuckyManamela_2025\DatabaseAdministration\SQLStatements\Sambe_Graduates2025LogFile.ldf')
