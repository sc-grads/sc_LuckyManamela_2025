EXEC sp_get_distributor;
Go

EXEC sp_adddistributor 
    @distributor = @@SERVERNAME,  -- Use the local server as the Distributor
    @password = 'LuckyManamela@1991';  -- Set a secure password for the Distributor

