using Microsoft.AspNetCore.Mvc.Rendering;

namespace CarteleraCine.Models
{
    public class CalificacionP
    {
        public Calificacione oCalificacion { get; set; }

        public List<SelectListItem> oIdPelicula { get; set; }
    }
}
