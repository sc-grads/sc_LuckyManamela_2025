USE [OurFirstDB]
GO

/****** Object:  Table [dbo].[Personal_Info]    Script Date: 2025/03/10 19:58:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Personal_Info](
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[ID] [int] NOT NULL
) ON [PRIMARY]
GO


