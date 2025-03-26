-- Create a login for Auto_user
CREATE LOGIN Auto_user WITH PASSWORD = 'LuckyManamela@0910';

-- Create a user in the master database for the login
USE master;
CREATE USER Auto_user FOR LOGIN Auto_user;

-- Grant sysadmin role to give full access (adjust permissions as needed)
ALTER SERVER ROLE sysadmin ADD MEMBER Auto_user;
GO