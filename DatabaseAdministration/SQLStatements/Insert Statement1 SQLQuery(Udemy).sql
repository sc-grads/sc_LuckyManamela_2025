USE [OurFirstDB]
GO

INSERT INTO [dbo].[Personal_Info]
           ([FirstName]
           ,[LastName]
           ,[DateOfBirth]
           ,[ID])
     VALUES
           ('Lucky'
           ,'Manamela'
           ,'05/05/2000'
           ,0005)
GO

SELECT * 
FROM Personal_Info
GO
