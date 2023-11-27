using System;
using System.Collections.Generic;

namespace CarteleraCine.Models;

public partial class Sala
{
    public int SalaId { get; set; }

    public string Nombre { get; set; } = null!;

    public string TipoButacas { get; set; } = null!;

    public virtual ICollection<Funcione> Funciones { get; set; } = new List<Funcione>();
}
