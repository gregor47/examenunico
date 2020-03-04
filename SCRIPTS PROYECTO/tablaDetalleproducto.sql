USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[DetallePedido]    Script Date: 04/03/2020 14:27:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DetallePedido](
	[id_producto] [nchar](10) NULL,
	[id_usuario] [nchar](10) NULL,
	[id_pedido] [nchar](10) NULL,
	[nombre_producto] [nchar](50) NULL,
	[cantidad] [int] NULL,
	[master] [int] NULL
) ON [PRIMARY]
GO

