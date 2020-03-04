USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[Pedidos]    Script Date: 04/03/2020 14:28:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pedidos](
	[id_pedido] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NULL,
	[descripcion] [nchar](1000) NULL,
	[estado] [bit] NULL
) ON [PRIMARY]
GO

