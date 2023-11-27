using System;
using System.Collections.Generic;

namespace CarteleraCine.Models;

public partial class Calificacione
{
    public int CalificacionId { get; set; }

    public int PeliculaId { get; set; }

    public byte Puntuacion { get; set; }

    public DateTime FechaCalificacion { get; set; }

    public virtual Pelicula Pelicula { get; set; } = null!;
}
