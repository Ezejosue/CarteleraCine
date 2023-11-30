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

	('Avatar', 'Un marine en un mundo alienígena se involucra en un conflicto entre humanos y nativos.', 'James Cameron', 'Ciencia ficción', 'PG-13', 162, 'Estándar', '/uploads/Avatar.jpg'),
    ('The Shawshank Redemption', 'Un hombre inocente encuentra la redención en una prisión de máxima seguridad.', 'Frank Darabont', 'Drama', 'R', 142, 'VIP', '/uploads/ShawshankRedemption.jpg'),
    ('The Dark Knight', 'Batman se enfrenta a su enemigo más siniestro, el Joker.', 'Christopher Nolan', 'Acción', 'PG-13', 152, 'Estándar', '/uploads/DarkKnight.jpg'),
    ('Forrest Gump', 'Un hombre con discapacidad intelectual vive una vida extraordinaria.', 'Robert Zemeckis', 'Drama', 'PG-13', 142, 'VIP', '/uploads/ForrestGump.jpg'),
    ('Interstellar', 'Un grupo de exploradores viaja a través de un agujero de gusano en busca de un nuevo hogar para la humanidad.', 'Christopher Nolan', 'Ciencia ficción', 'PG-13', 169, 'IMAX', '/uploads/Interstellar.jpg'),
    ('The Matrix', 'Un hacker descubre que vive en un mundo simulado y se une a la resistencia contra las máquinas.', 'The Wachowskis', 'Ciencia ficción', 'R', 136, 'Estándar', '/uploads/Matrix.jpg'),
    ('The Godfather Part II', 'La saga de una familia mafiosa continúa mientras el joven Vito Corleone se convierte en un poderoso líder.', 'Francis Ford Coppola', 'Drama', 'R', 202, 'Estándar', '/uploads/GodfatherPartII.jpg'),
    ('Schindler''s List', 'Un empresario alemán salva a un grupo de judíos durante el Holocausto.', 'Steven Spielberg', 'Drama', 'R', 195, 'VIP', '/uploads/SchindlersList.jpg'),
    ('Pulp Fiction', 'Varios personajes se entrelazan en una trama de crimen y redención.', 'Quentin Tarantino', 'Crimen', 'R', 154, 'Estándar', '/uploads/PulpFiction.jpg');

GO

INSERT INTO Calificaciones (PeliculaID, Puntuacion, FechaCalificacion)
VALUES
    (4, 4, GETDATE()),
    (5, 5, GETDATE()),
    (6, 3, GETDATE()),
    (7, 4, GETDATE()),
    (8, 5, GETDATE()),
    (9, 3, GETDATE()),
	(10, 4, GETDATE()),
    (11, 5, GETDATE()),
    (12, 3, GETDATE()),
    (13, 4, GETDATE()),
    (14, 5, GETDATE()),
    (15, 3, GETDATE()),
	(16, 4, GETDATE()),
    (17, 5, GETDATE()),
    (18, 3, GETDATE());
GO


INSERT INTO Funciones (PeliculaID, SalaID, Horario)
VALUES
    (4, 1, '2023-12-01 15:00:00'), -- Ejemplo de horario para Película 4
    (5, 1, '2023-12-01 17:30:00'), -- Ejemplo de horario para Película 5
    (6, 1, '2023-12-01 20:00:00'), -- Ejemplo de horario para Película 6
    (7, 1, '2023-12-02 14:00:00'), -- Ejemplo de horario para Película 7
    (8, 1, '2023-12-02 16:30:00'), -- Ejemplo de horario para Película 8
    (9, 1, '2023-12-02 19:00:00'),
	(10, 1, '2023-12-03 16:00:00'),
    (11, 1, '2023-12-03 18:30:00'),
    (12, 1, '2023-12-03 21:00:00'),
    (13, 1, '2023-12-04 15:00:00'),
    (14, 1, '2023-12-04 17:30:00'),
    (15, 1, '2023-12-04 20:00:00'),
	(16, 1, '2023-12-05 16:00:00'),
    (17, 1, '2023-12-05 18:30:00'),
    (18, 1, '2023-12-05 21:00:00');
GO


SELECT * FROM Peliculas;
SELECT * FROM Calificaciones;
SELECT * FROM Funciones;