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



INSERT INTO Peliculas (Titulo, Sinopsis, Director, Genero, Clasificacion, Duracion, TipoButacas, Poster)
VALUES
    ('El Padrino', 'Un poderoso jefe de la mafia busca mantener el control de su imperio criminal.', 'Francis Ford Coppola', 'Drama', 'R', 175, 'VIP', '/uploads/John.jpg'),
    ('Titanic', 'Un romance épico entre pasajeros a bordo del famoso barco que se hunde.', 'James Cameron', 'Romance', 'PG-13', 195, 'Estándar', '/uploads/John.jpg'),
    ('Star Wars: Episodio IV', 'Un joven granjero se convierte en un héroe galáctico en una galaxia lejana.', 'George Lucas', 'Ciencia ficción', 'PG', 121, 'IMAX', '/uploads/John.jpg'),
    ('Jurassic Park', 'Un parque de dinosaurios genéticamente recreados se sale de control.', 'Steven Spielberg', 'Aventura', 'PG-13', 127, 'Estándar', '/uploads/John.jpg'),
    ('Inception', 'Un ladrón de sueños entra en la mente de las personas para robar secretos.', 'Christopher Nolan', 'Ciencia ficción', 'PG-13', 148, 'VIP', '/uploads/John.jpg');
GO

INSERT INTO Calificaciones (PeliculaID, Puntuacion, FechaCalificacion)
VALUES
    (4, 4, GETDATE()),
    (5, 5, GETDATE()),
    (6, 3, GETDATE()),
    (7, 4, GETDATE()),
    (8, 5, GETDATE()),
    (9, 3, GETDATE());
	
GO


INSERT INTO Funciones (PeliculaID, SalaID, Horario)
VALUES
    (4, 1, '2023-12-01 15:00:00'), -- Ejemplo de horario para Película 4
    (5, 1, '2023-12-01 17:30:00'), -- Ejemplo de horario para Película 5
    (6, 1, '2023-12-01 20:00:00'), -- Ejemplo de horario para Película 6
    (7, 1, '2023-12-02 14:00:00'), -- Ejemplo de horario para Película 7
    (8, 1, '2023-12-02 16:30:00'), -- Ejemplo de horario para Película 8
    (9, 1, '2023-12-02 19:00:00');
GO


SELECT * FROM Peliculas;
SELECT * FROM Calificaciones;
SELECT * FROM Funciones;