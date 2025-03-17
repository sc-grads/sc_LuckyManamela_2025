--Transaction Log Operations and Monitoring

/*Issueing a CHECKPOINT command to flush all dirty pages (modified in-memory pages)
to disk. This helps in marking log records as no longer needed for recovery,
facilitating log truncation.*/
CHECKPOINT;
GO


/*Running a DBCC command to display the percentage of space used in the transaction log 
for each database. This is useful for monitoring log space consumption.*/
DBCC SQLPERF(LOGSPACE);
GO
