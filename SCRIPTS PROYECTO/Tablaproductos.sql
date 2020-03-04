USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[Productos]    Script Date: 04/03/2020 14:30:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Productos](
	[id_producto] [bigint] IDENTITY(1,1) NOT NULL,
	[nombre] [nchar](50) NULL,
	[stock] [int] NULL,
	[Precio] [int] NULL
) ON [PRIMARY]
GO

