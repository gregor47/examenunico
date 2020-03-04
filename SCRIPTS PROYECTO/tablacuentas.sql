USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[Cuentas]    Script Date: 04/03/2020 14:08:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cuentas](
	[id_cuenta] [bigint] IDENTITY(1,1) NOT NULL,
	[id_usuario] [bigint] NULL,
	[tarjeta] [bigint] NOT NULL,
	[disponible] [bigint] NULL,
 CONSTRAINT [PK_Cuentass] PRIMARY KEY CLUSTERED 
(
	[tarjeta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


