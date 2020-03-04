USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[PedidosMaster]    Script Date: 04/03/2020 14:29:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PedidosMaster](
	[id_gestion] [int] IDENTITY(1,1) NOT NULL,
	[id_pedido] [int] NULL,
	[cobrado] [bit] NULL,
	[descripcion] [nchar](1000) NULL,
	[id_user] [int] NULL,
	[estado] [bit] NULL,
	[cobrado_descriptcion] [nchar](1000) NULL
) ON [PRIMARY]
GO

