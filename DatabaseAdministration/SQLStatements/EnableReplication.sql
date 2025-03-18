USE master;
-- Enable replication for AdventureWorks2016
EXEC sp_replicationdboption 
    @dbname = 'AdventureWorks2016', 
    @optname = 'publish', 
    @value = 'true';
