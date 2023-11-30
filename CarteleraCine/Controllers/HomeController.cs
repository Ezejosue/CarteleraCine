using CarteleraCine.Models;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;
using Microsoft.EntityFrameworkCore;
using X.PagedList;

namespace CarteleraCine.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly CinePlusContext _context;

        public HomeController(ILogger<HomeController> logger, CinePlusContext context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<IActionResult> Index(int? page)
        {
            /*return _context.Peliculas != null ?
                         View(await _context.Peliculas.ToListAsync()) :
                         Problem("Entity set 'CinePlusContext.Peliculas'  is null.");*/

            int pageNumber = page ?? 1;
            int pageSize = 4; // Una tarjeta por página

            var model = _context.Peliculas
               .Include(p => p.Calificaciones)
               .ToPagedList(pageNumber, pageSize);

            return View(model);
        }


        // GET: Home/Detalle/5
        public async Task<IActionResult> Detalle(int? id)
        {
            if (id == null || _context.Peliculas == null)
            {
                return NotFound();
            }

            var pelicula = await _context.Peliculas
                .FirstOrDefaultAsync(m => m.PeliculaId == id);
            if (pelicula == null)
            {
                return NotFound();
            }

            return View(pelicula);
        }

    

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}