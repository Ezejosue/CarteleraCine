# Cine+ - Cartelera de Películas

Cine+ es una aplicación web que presenta una cartelera de películas y permite a los usuarios ver información detallada de las películas, calificarlas y ver un ranking de las películas mejor calificadas. La aplicación utiliza una base de datos SQL Server para almacenar la información de las películas y las calificaciones de los usuarios.

## Características Principales

- Mostrar la cartelera de películas con paginación de resultados.
- Ver información detallada de cada película, incluyendo el póster, título, sinopsis, director y género.
- Calificar las películas y guardar las calificaciones en la base de datos.
- Ver un ranking de las 5 películas con mayor puntuación.

## Tecnologías Utilizadas

- ASP.NET Core para el backend.
- SQL Server para la base de datos.
- HTML, CSS y JavaScript para el frontend.
- Entity Framework Core para la comunicación con la base de datos.
- Bootstrap para el diseño y la interfaz de usuario.

## Configuración del Proyecto

1. Clona este repositorio a tu máquina local.
2. Configura una base de datos SQL Server y actualiza la cadena de conexión en `appsettings.json`.
3. Ejecuta las migraciones para crear las tablas de la base de datos: `dotnet ef database update`.
4. Ejecuta la aplicación: `dotnet run`.

## Uso

- Accede a la página principal para ver la cartelera de películas.
- Haz clic en una película para ver más detalles y calificarla.
- Visita la página de ranking para ver las películas mejor calificadas.

## Contribuir

Si deseas contribuir a este proyecto, ¡serás bienvenido! Puedes abrir un problema (issue) o enviar una solicitud de extracción (pull request) para proponer mejoras o correcciones.

## Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

¡Disfruta de tu experiencia en Cine+ y disfruta de las películas!
