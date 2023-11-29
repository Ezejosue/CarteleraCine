using Microsoft.AspNetCore.Mvc.Rendering;

namespace CarteleraCine.Models
{
    public class FuncionP
    {
        
            public Funcione oFuncion { get; set; }

            public List<SelectListItem> oIdPelicula { get; set; }

            public List<SelectListItem> oIdSala { get; set; }
    }
}
