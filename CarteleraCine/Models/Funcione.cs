using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CarteleraCine.Models;

public partial class Funcione
{
    public int FuncionId { get; set; }

    public int PeliculaId { get; set; }

    public int SalaId { get; set; }


    [DataType(DataType.DateTime)]
    public DateTime Horario { get; set; }

    public virtual Pelicula Pelicula { get; set; } = null!;

    public virtual Sala Sala { get; set; } = null!;
}
