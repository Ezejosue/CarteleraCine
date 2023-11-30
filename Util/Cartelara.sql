CREATE DATABASE CinePlus;
GO

USE CinePlus;
GO

-- Crear Tabla Peliculas
CREATE TABLE Peliculas (
    PeliculaID INT PRIMARY KEY IDENTITY(1,1),
    Titulo NVARCHAR(255) NOT NULL,
    Sinopsis NVARCHAR(MAX) NOT NULL,
    Director NVARCHAR(255) NOT NULL,
    Genero NVARCHAR(50) NOT NULL,
    Clasificacion NVARCHAR(5),
    Duracion INT, -- Duración en minutos
    TipoButacas NVARCHAR(50), 
    Poster VARBINARY(MAX) -- Opcional, para almacenar imagen
);

GO

ALTER TABLE Peliculas
ALTER COLUMN Poster NVARCHAR(MAX);
GO

-- Crear Tabla Calificaciones
CREATE TABLE Calificaciones (
    CalificacionID INT PRIMARY KEY IDENTITY(1,1),
    PeliculaID INT NOT NULL,
    Puntuacion TINYINT NOT NULL CHECK (Puntuacion BETWEEN 1 AND 5),
    FechaCalificacion DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID)
);

GO

-- Crear Tabla Salas
CREATE TABLE Salas (
    SalaID INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    TipoButacas NVARCHAR(50) NOT NULL 
);

GO

-- Crear Tabla Funciones
CREATE TABLE Funciones (
    FuncionID INT PRIMARY KEY IDENTITY(1,1),
    PeliculaID INT NOT NULL,
    SalaID INT NOT NULL,
    Horario DATETIME NOT NULL,
    FOREIGN KEY (PeliculaID) REFERENCES Peliculas(PeliculaID),
    FOREIGN KEY (SalaID) REFERENCES Salas(SalaID)
);
GO

ALTER TABLE Funciones
ALTER COLUMN Horario DATETIME2;

-- Procedimiento Almacenado para Obtener el Ranking de Películas
CREATE PROCEDURE GetTopRankedMovies AS
BEGIN
    SELECT TOP 5 P.PeliculaID, P.Titulo, AVG(C.Puntuacion) as PromedioPuntuacion
    FROM Peliculas P
    JOIN Calificaciones C ON P.PeliculaID = C.PeliculaID
    GROUP BY P.PeliculaID, P.Titulo
    ORDER BY PromedioPuntuacion DESC, P.Titulo; -- En caso de empates, ordena alfabéticamente
END;
GO

-- Procedimiento Almacenado para Paginación de Películas
CREATE PROCEDURE GetMoviesPage
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