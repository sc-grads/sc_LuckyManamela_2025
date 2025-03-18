--Setting Up Transactional Replication (Conceptual Steps)


-- Enable the server as a Publisher (run on Publisher server)
EXEC sp_replicationdboption 
    @dbname = N'AdventureWorks2016', 
    @optname = N'publish', 
    @value = N'true';
GO

-- Step 2: Create a publication (run on Publisher server)
EXEC sp_addpublication 
    @publication = N'AdventureWorksPublication', 
    @status = N'active', 
    @allow_push = N'true', 
    @allow_pull = N'true';
GO

-- Step 3: Add articles (tables) to the publication
EXEC sp_addarticle 
    @publication = N'AdventureWorksPublication', 
    @article = N'SalesOrderHeader', 
    @source_object = N'SalesOrderHeader';
GO

