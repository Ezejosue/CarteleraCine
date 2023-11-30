USE [master]
GO
/****** Object:  Database [CinePlus]    Script Date: 29/11/2023 23:47:31 ******/
CREATE DATABASE [CinePlus]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinePlus', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\CinePlus.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CinePlus_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLSERVER\MSSQL\DATA\CinePlus_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CinePlus] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinePlus].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinePlus] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinePlus] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinePlus] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinePlus] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinePlus] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinePlus] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinePlus] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinePlus] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinePlus] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinePlus] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinePlus] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinePlus] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinePlus] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinePlus] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinePlus] SET  ENABLE_BROKER 
GO
ALTER DATABASE [CinePlus] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinePlus] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinePlus] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinePlus] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinePlus] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinePlus] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinePlus] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinePlus] SET RECOVERY FULL 
GO
ALTER DATABASE [CinePlus] SET  MULTI_USER 
GO
ALTER DATABASE [CinePlus] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinePlus] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinePlus] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinePlus] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CinePlus] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CinePlus] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CinePlus', N'ON'
GO
ALTER DATABASE [CinePlus] SET QUERY_STORE = ON
GO
ALTER DATABASE [CinePlus] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CinePlus]
GO
/****** Object:  Table [dbo].[Calificaciones]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Calificaciones](
	[CalificacionID] [int] IDENTITY(1,1) NOT NULL,
	[PeliculaID] [int] NOT NULL,
	[Puntuacion] [tinyint] NOT NULL,
	[FechaCalificacion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CalificacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Funciones]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Funciones](
	[FuncionID] [int] IDENTITY(1,1) NOT NULL,
	[PeliculaID] [int] NOT NULL,
	[SalaID] [int] NOT NULL,
	[Horario] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FuncionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peliculas]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peliculas](
	[PeliculaID] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [nvarchar](255) NOT NULL,
	[Sinopsis] [nvarchar](max) NOT NULL,
	[Director] [nvarchar](255) NOT NULL,
	[Genero] [nvarchar](50) NOT NULL,
	[Clasificacion] [nvarchar](5) NULL,
	[Duracion] [int] NULL,
	[TipoButacas] [nvarchar](50) NULL,
	[Poster] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[PeliculaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salas]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salas](
	[SalaID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[TipoButacas] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Peliculas] ON 

INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (2, N'Element', N'Las diferencias nos hacen únicos ', N'Gael López ', N'Infantil', N'4', 120, N'2D', N'/uploads/element.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (3, N'Wonka ', N'La Fábrica de chocolates regresa ', N'Kally Rodriguez', N'Fantacia', N'3', 90, N'2D', N'/uploads/wonka.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (4, N'Barby', N'Barby deja de ser una muñeca para ser mujer real', N'Greta Gerwig', N'Comedia', N'5', 105, N'3D', N'/uploads/barby.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (5, N'Digimon Ultra', N'Una aventura para crea y entrenar monstruos', N'Bandai Namco', N'Anime', N'3', 90, N'2D', N'/uploads/Digi.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (6, N'Fast X', N'Toretto y su familia han sido capaces de sobrellevarlas.', N' Louis Leterrier', N'accion', N'DD', 120, N'3D', N'/uploads/fast.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (7, N'Guardiana de la Galaxia', N'La Historia de cómo se crearon los guardianes', N'James Gunn', N'Ficción ', N'AA', 135, N'3D', N'/uploads/gala.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (8, N'Mision Imposible ', N'Ethan debe de detener a una AI ', N'McQuarrie', N'Accion ', N'DD', 120, N'2D', N'/uploads/mision.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (9, N'Napoleon ', N'Una mirada a los orígenes del comandante', N'Ridley Scott', N'Drama', N'DD', 125, N'2D', N'/uploads/Napo.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (10, N'Oppenheimer', N'El físico J Robert Oppenheimer trabaja con un equipo de científicos', N'Christopher Nolan', N'Drama', N'DD', 140, N'2D', N'/uploads/open.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (11, N'Puerta Magica', N'Un hombre consigue unas prácticas en una misteriosa empresa', N'Jeffrey Walker', N'Fantacia', N'AA', 100, N'2D', N'/uploads/puerta.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (12, N'La Sirenita ', N'Ariel, una pequeña sirena, está a punto de celebrar su fiesta de cumpleaños', N'John Musker, Ron Clements', N'Infantil ', N'AA', 90, N'2D', N'/uploads/sire.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (13, N'Viernes Negro ', N'un disturbio termina en tragedia en el Viernes Negro', N'Eli Roth', N'Suspenso', N'DD', 120, N'2D', N'/uploads/viernes.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (14, N'Whis ', N'El poder de los deseos” es una comedia musica', N'Chris Buck', N'Fantacia', N'AA', 90, N'2D', N'/uploads/whis.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (15, N'El Ultimo Zombi ', N'Sigue la vida del científico especialista en genética', N'Martín Basterretche', N'Suspenso', N'DD', 125, N'3D', N'/uploads/zombie.jpg')
INSERT [dbo].[Peliculas] ([PeliculaID], [Titulo], [Sinopsis], [Director], [Genero], [Clasificacion], [Duracion], [TipoButacas], [Poster]) VALUES (16, N'La Consagración ', N'La misteriosa muerte de su hermano la llevan a vivir el terror ', N'Christopher Smith', N'Miedo', N'Dd', 136, N'3D', N'/uploads/diablo.jpg')
SET IDENTITY_INSERT [dbo].[Peliculas] OFF
GO
SET IDENTITY_INSERT [dbo].[Salas] ON 

INSERT [dbo].[Salas] ([SalaID], [Nombre], [TipoButacas]) VALUES (1, N'Sala 1', N'2D')
INSERT [dbo].[Salas] ([SalaID], [Nombre], [TipoButacas]) VALUES (2, N'Sala 2', N'3D')
INSERT [dbo].[Salas] ([SalaID], [Nombre], [TipoButacas]) VALUES (3, N'Sala 3', N'2D')
SET IDENTITY_INSERT [dbo].[Salas] OFF
GO
ALTER TABLE [dbo].[Calificaciones] ADD  DEFAULT (getdate()) FOR [FechaCalificacion]
GO
ALTER TABLE [dbo].[Calificaciones]  WITH CHECK ADD FOREIGN KEY([PeliculaID])
REFERENCES [dbo].[Peliculas] ([PeliculaID])
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD FOREIGN KEY([PeliculaID])
REFERENCES [dbo].[Peliculas] ([PeliculaID])
GO
ALTER TABLE [dbo].[Funciones]  WITH CHECK ADD FOREIGN KEY([SalaID])
REFERENCES [dbo].[Salas] ([SalaID])
GO
ALTER TABLE [dbo].[Calificaciones]  WITH CHECK ADD CHECK  (([Puntuacion]>=(1) AND [Puntuacion]<=(5)))
GO
/****** Object:  StoredProcedure [dbo].[GetMoviesPage]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimiento Almacenado para Paginación de Películas
CREATE PROCEDURE [dbo].[GetMoviesPage]
    @PageNumber INT = 1,
    @PageSize INT = 15
AS
BEGIN
    WITH MovieCTE AS (
        SELECT *,
        ROW_NUMBER() OVER (ORDER BY Titulo) as RowNum
        FROM Peliculas
    )
    SELECT PeliculaID, Titulo, Sinopsis, Director, Genero, Poster
    FROM MovieCTE
    WHERE RowNum BETWEEN (@PageNumber - 1) * @PageSize + 1 AND @PageNumber * @PageSize
    ORDER BY Titulo;
END;
GO
/****** Object:  StoredProcedure [dbo].[GetTopRankedMovies]    Script Date: 29/11/2023 23:47:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento Almacenado para Obtener el Ranking de Películas
CREATE PROCEDURE [dbo].[GetTopRankedMovies] AS
BEGIN
    SELECT TOP 5 P.PeliculaID, P.Titulo, AVG(C.Puntuacion) as PromedioPuntuacion
    FROM Peliculas P
    JOIN Calificaciones C ON P.PeliculaID = C.PeliculaID
    GROUP BY P.PeliculaID, P.Titulo
    ORDER BY PromedioPuntuacion DESC, P.Titulo; -- En caso de empates, ordena alfabéticamente
END;
GO
USE [master]
GO
ALTER DATABASE [CinePlus] SET  READ_WRITE 
GO
