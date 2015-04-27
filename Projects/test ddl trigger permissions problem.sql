sp_configure 'cross db ownership chaining',0
GO
RECONFIGURE WITH OVERRIDE
GO

USE [DynamicSortOrder]
GO

SETUSER 'dynamicsortorderuser'
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[BrandGrid1125xx](
      [Sequence] [int] NOT NULL,
      [Bucket] [int] NOT NULL,
      [Brand] [varchar](12) NOT NULL,
      [Rank] [int] NOT NULL,
      [FreshRank] [int] NULL,
CONSTRAINT [PK_BrandGrid1125] PRIMARY KEY CLUSTERED 
(
      [Sequence] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
DROP TABLE [dbo].[BrandGrid1125xx]
GO

SETUSER
GO

ALTER DATABASE [DynamicSortOrder] SET DB_CHAINING OFF
ALTER DATABASE [dbaadmin] SET DB_CHAINING OFF
ALTER DATABASE [deplinfo] SET DB_CHAINING OFF
ALTER DATABASE [dbaperf] SET DB_CHAINING OFF