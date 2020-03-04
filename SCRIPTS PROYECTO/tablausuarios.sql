USE [Work_DataBase]
GO

/****** Object:  Table [dbo].[Usuarios]    Script Date: 04/03/2020 14:31:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Usuarios](
	[id_usuario] [bigint] IDENTITY(1,1) NOT NULL,
	[username] [nchar](50) NULL,
	[contrasena] [nchar](50) NULL,
	[email] [nchar](50) NULL,
	[direccion] [nchar](100) NULL,
	[telefono] [bigint] NULL,
	[perfil] [bit] NULL,
	[nombre] [nchar](50) NULL,
	[apellido] [nchar](50) NULL
) ON [PRIMARY]
GO

