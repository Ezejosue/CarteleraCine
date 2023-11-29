using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using CarteleraCine.Models;

namespace CarteleraCine.Controllers
{
    public class CalificacionesController : Controller
    {
        private readonly CinePlusContext _context;

        public CalificacionesController(CinePlusContext context)
        {
            _context = context;
        }

        // GET: Calificaciones
        public async Task<IActionResult> Index()
        {
            var cinePlusContext = _context.Calificaciones.Include(c => c.Pelicula);
            return View(await cinePlusContext.ToListAsync());
        }

        // GET: Calificaciones/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null || _context.Calificaciones == null)
            {
                return NotFound();
            }

            var calificacione = await _context.Calificaciones
                .Include(c => c.Pelicula)
                .FirstOrDefaultAsync(m => m.CalificacionId == id);
            if (calificacione == null)
            {
                return NotFound();
            }

            return View(calificacione);
        }



        // GET: Calificaciones/Create
        [HttpGet]
        public IActionResult Create()
        {
            CalificacionP calificacionP = new CalificacionP() {
                oCalificacion = new Calificacione(),
                oIdPelicula = _context.Peliculas.Select(Pelicula => new SelectListItem() {
                    Text = Pelicula.Titulo,
                    Value = Pelicula.PeliculaId.ToString()
                }).ToList()
            };
            

            return View(calificacionP);
        }

        // POST: Calificaciones/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(CalificacionP calificacion)
        {

            if (calificacion.oCalificacion.CalificacionId==0)
            {
                _context.Calificaciones.Add(calificacion.oCalificacion);
            }
            _context.SaveChanges();

            return RedirectToAction("Index");

        }

        // GET: Calificaciones/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {

            CalificacionP calificacionP = new CalificacionP()
            {
                oCalificacion = new Calificacione(),
                oIdPelicula = _context.Peliculas.Select(Pelicula => new SelectListItem()
                {
                    Text = Pelicula.Titulo,
                    Value = Pelicula.PeliculaId.ToString()
                }).ToList()
            };

            if (id!=0)
            {
                calificacionP.oCalificacion = _context.Calificaciones.Find(id);
            }

          
            return View(calificacionP);
        }

        // POST: Calificaciones/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(CalificacionP calificacion)
        {
            if (calificacion.oCalificacion.CalificacionId==0)
            {
                _context.Calificaciones.Add(calificacion.oCalificacion);
            }
            else
            {
                _context.Calificaciones.Update(calificacion.oCalificacion);
            }

            _context.SaveChanges();
            return RedirectToAction("Index");
        }

        // GET: Calificaciones/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null || _context.Calificaciones == null)
            {
                return NotFound();
            }

            var calificacione = await _context.Calificaciones
                .Include(c => c.Pelicula)
                .FirstOrDefaultAsync(m => m.CalificacionId == id);
            if (calificacione == null)
            {
                return NotFound();
            }

            return View(calificacione);
        }

        // POST: Calificaciones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Calificaciones == null)
            {
                return Problem("Entity set 'CinePlusContext.Calificaciones'  is null.");
            }
            var calificacione = await _context.Calificaciones.FindAsync(id);
            if (calificacione != null)
            {
                _context.Calificaciones.Remove(calificacione);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool CalificacioneExists(int id)
        {
          return (_context.Calificaciones?.Any(e => e.CalificacionId == id)).GetValueOrDefault();
        }
    }
}
