/*Setting the recovery model of MyTestDB to FULL,
the FULL recovery model supports point-in-time recovery by fully logging all transactions.*/
ALTER DATABASE MyTestDB SET RECOVERY FULL;
GO
