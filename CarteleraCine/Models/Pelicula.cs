using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace CarteleraCine.Models;

public partial class Pelicula
{
    public int PeliculaId { get; set; }

    public string Titulo { get; set; } = null!;

    public string Sinopsis { get; set; } = null!;

    public string Director { get; set; } = null!;

    public string Genero { get; set; } = null!;

    public string? Clasificacion { get; set; }

    public int? Duracion { get; set; }

    public string? TipoButacas { get; set; }

    public string? Poster { get; set; }


    [NotMapped]
    public IFormFile? PosterFile { get; set; }


    public virtual ICollection<Calificacione> Calificaciones { get; set; } = new List<Calificacione>();

    public virtual ICollection<Funcione> Funciones { get; set; } = new List<Funcione>();
}
