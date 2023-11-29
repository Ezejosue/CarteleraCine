using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CarteleraCine.Models;
using System.Globalization;

namespace CarteleraCine.Controllers
{
    public class FuncionesController : Controller
    {
        private readonly CinePlusContext _context;

        public FuncionesController(CinePlusContext context)
        {
            _context = context;
        }

        // GET: Funciones
        public async Task<IActionResult> Index()
        {
            var cinePlusContext = _context.Funciones.Include(f => f.Pelicula).Include(f => f.Sala);
            return View(await cinePlusContext.ToListAsync());
        }

        // GET: Funciones/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Funciones == null)
            {
                return NotFound();
            }

            var funcione = await _context.Funciones
                .Include(f => f.Pelicula)
                .Include(f => f.Sala)
                .FirstOrDefaultAsync(m => m.FuncionId == id);
            if (funcione == null)
            {
                return NotFound();
            }

            return View(funcione);
        }

        // GET: Funciones/Create
        [HttpGet]
        public IActionResult Create()
        {
            FuncionP funcionP = new FuncionP()
            {
                oFuncion = new Funcione(),
                oIdPelicula = _context.Peliculas.Select(Pelicula => new SelectListItem()
                {
                    Text = Pelicula.Titulo,
                    Value = Pelicula.PeliculaId.ToString()
                }).ToList(),
                oIdSala = _context.Salas.Select(Sala => new SelectListItem()
                {
                    Text = Sala.Nombre,
                    Value = Sala.SalaId.ToString()
                }).ToList()


            };


            return View(funcionP);
        }
        // POST: Funciones/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(FuncionP funcion)
        {
            Console.WriteLine(funcion.oFuncion.SalaId + " " + funcion.oFuncion.PeliculaId + " " + funcion.oFuncion.Horario);

            string fechaHoraString = funcion.oFuncion.Horario.ToString();


            if (DateTime.TryParse(fechaHoraString, CultureInfo.InvariantCulture, DateTimeStyles.None, out var fechaHora))
            {
                funcion.oFuncion.Horario = fechaHora;


                Console.WriteLine(funcion.oFuncion.SalaId + " " + funcion.oFuncion.PeliculaId + " " + funcion.oFuncion.Horario);
                if (funcion.oFuncion.FuncionId == 0)
                {
                    _context.Funciones.Add(funcion.oFuncion);
                }

            }

            _context.SaveChanges();

            return RedirectToAction("Index");

        }

        // GET: Funciones/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            FuncionP funcionP = new FuncionP()
            {
                oFuncion = new Funcione(),
                oIdPelicula = _context.Peliculas.Select(Pelicula => new SelectListItem()
                {
                    Text = Pelicula.Titulo,
                    Value = Pelicula.PeliculaId.ToString()
                }).ToList(),
                oIdSala = _context.Salas.Select(Sala => new SelectListItem()
                {
                    Text = Sala.Nombre,
                    Value = Sala.SalaId.ToString()
                }).ToList()


            };

            if (id!=0)
            {
                funcionP.oFuncion = _context.Funciones.Find(id);
            }

            return View(funcionP);
        }

        // POST: Funciones/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(FuncionP funcion)
        {
            if (funcion.oFuncion.FuncionId == 0)
            {
                _context.Funciones.Add(funcion.oFuncion);
            }
            else { 
                _context.Funciones.Update(funcion.oFuncion);
            }

            _context.SaveChanges();

            return RedirectToAction("Index");
        }

        // GET: Funciones/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Funciones == null)
            {
                return NotFound();
            }

            var funcione = await _context.Funciones
                .Include(f => f.Pelicula)
                .Include(f => f.Sala)
                .FirstOrDefaultAsync(m => m.FuncionId == id);
            if (funcione == null)
            {
                return NotFound();
            }

            return View(funcione);
        }

        // POST: Funciones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Funciones == null)
            {
                return Problem("Entity set 'CinePlusContext.Funciones'  is null.");
            }
            var funcione = await _context.Funciones.FindAsync(id);
            if (funcione != null)
            {
                _context.Funciones.Remove(funcione);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool FuncioneExists(int id)
        {
          return (_context.Funciones?.Any(e => e.FuncionId == id)).GetValueOrDefault();
        }
    }
}
