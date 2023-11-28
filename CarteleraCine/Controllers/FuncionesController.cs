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
        public IActionResult Create()
        {
            ViewData["PeliculaId"] = new SelectList(_context.Peliculas, "PeliculaId", "PeliculaId");
            ViewData["SalaId"] = new SelectList(_context.Salas, "SalaId", "SalaId");
            return View();
        }

        // POST: Funciones/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("FuncionId,PeliculaId,SalaId,Horario")] Funcione funcione)
        {
            if (ModelState.IsValid)
            {
                _context.Add(funcione);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["PeliculaId"] = new SelectList(_context.Peliculas, "PeliculaId", "PeliculaId", funcione.PeliculaId);
            ViewData["SalaId"] = new SelectList(_context.Salas, "SalaId", "SalaId", funcione.SalaId);
            return View(funcione);
        }

        // GET: Funciones/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Funciones == null)
            {
                return NotFound();
            }

            var funcione = await _context.Funciones.FindAsync(id);
            if (funcione == null)
            {
                return NotFound();
            }
            ViewData["PeliculaId"] = new SelectList(_context.Peliculas, "PeliculaId", "PeliculaId", funcione.PeliculaId);
            ViewData["SalaId"] = new SelectList(_context.Salas, "SalaId", "SalaId", funcione.SalaId);
            return View(funcione);
        }

        // POST: Funciones/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("FuncionId,PeliculaId,SalaId,Horario")] Funcione funcione)
        {
            if (id != funcione.FuncionId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(funcione);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FuncioneExists(funcione.FuncionId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["PeliculaId"] = new SelectList(_context.Peliculas, "PeliculaId", "PeliculaId", funcione.PeliculaId);
            ViewData["SalaId"] = new SelectList(_context.Salas, "SalaId", "SalaId", funcione.SalaId);
            return View(funcione);
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
