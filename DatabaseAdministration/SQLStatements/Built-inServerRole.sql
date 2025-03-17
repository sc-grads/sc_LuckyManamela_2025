--Adding a Login to a Built-in Server Role

--Add 'MySQLLogin' to the sysadmin role
EXEC sp_addsrvrolemember 'MySQLLogin', 'sysadmin';
GO
