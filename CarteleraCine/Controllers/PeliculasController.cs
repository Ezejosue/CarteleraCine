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
    public class PeliculasController : Controller
    {
        private readonly CinePlusContext _context;

        public PeliculasController(CinePlusContext context)
        {
            _context = context;
        }

        // GET: Peliculas
        public async Task<IActionResult> Index()
        {
              return _context.Peliculas != null ? 
                          View(await _context.Peliculas.ToListAsync()) :
                          Problem("Entity set 'CinePlusContext.Peliculas'  is null.");
        }

        // GET: Peliculas/Details/5
        public async Task<IActionResult> Details(int? id)
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

        // GET: Peliculas/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Peliculas/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("PeliculaId,Titulo,Sinopsis,Director,Genero,Clasificacion,Duracion,TipoButacas,PosterFile")] Pelicula pelicula)
        {
            if (ModelState.IsValid)
            {
                if (pelicula.PosterFile != null && pelicula.PosterFile.Length > 0)
                {
                    var fileName = Path.GetFileName(pelicula.PosterFile.FileName);
                    var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads", fileName);

                    using (var fileStream = new FileStream(filePath, FileMode.Create))
                    {
                        await pelicula.PosterFile.CopyToAsync(fileStream);
                    }

                    pelicula.Poster = "/uploads/" + fileName;
                }


                _context.Add(pelicula);
                await _context.SaveChangesAsync();
                TempData["SuccessMessage"] = "Película creada con éxito."; // Establecer el mensaje

                return RedirectToAction(nameof(Index));
            }
            return View(pelicula);
        }

        // GET: Peliculas/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null || _context.Peliculas == null)
            {
                return NotFound();
            }

            var pelicula = await _context.Peliculas.FindAsync(id);
            if (pelicula == null)
            {
                return NotFound();
            }
            return View(pelicula);
        }

        // POST: Peliculas/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("PeliculaId,Titulo,Sinopsis,Director,Genero,Clasificacion,Duracion,TipoButacas,PosterFile")] Pelicula pelicula)
        {
            if (id != pelicula.PeliculaId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    var peliculaToUpdate = await _context.Peliculas.FindAsync(id);
                    if (peliculaToUpdate == null)
                    {
                        return NotFound();
                    }

                    if (pelicula.PosterFile != null && pelicula.PosterFile.Length > 0)
                    {
                        var fileName = Path.GetFileName(pelicula.PosterFile.FileName);
                        var filePath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads", fileName);

                        using (var fileStream = new FileStream(filePath, FileMode.Create))
                        {
                            await pelicula.PosterFile.CopyToAsync(fileStream);
                        }

                        peliculaToUpdate.Poster = "/uploads/" + fileName; 
                    }

                    peliculaToUpdate.Titulo = pelicula.Titulo;
                    peliculaToUpdate.Sinopsis = pelicula.Sinopsis;
                    peliculaToUpdate.Director = pelicula.Director;
                    peliculaToUpdate.Genero = pelicula.Genero;
                    peliculaToUpdate.Clasificacion = pelicula.Clasificacion;
                    peliculaToUpdate.Duracion = pelicula.Duracion;
                    peliculaToUpdate.TipoButacas = pelicula.TipoButacas;
                    

                    _context.Update(peliculaToUpdate);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!PeliculaExists(pelicula.PeliculaId))
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
            return View(pelicula);
        }

        // GET: Peliculas/Delete/5
        public async Task<IActionResult> Delete(int? id)
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

        // POST: Peliculas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            if (_context.Peliculas == null)
            {
                return Problem("Entity set 'CinePlusContext.Peliculas'  is null.");
            }
            var pelicula = await _context.Peliculas.FindAsync(id);
            if (pelicula != null)
            {
                _context.Peliculas.Remove(pelicula);
            }
            
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool PeliculaExists(int id)
        {
          return (_context.Peliculas?.Any(e => e.PeliculaId == id)).GetValueOrDefault();
        }
    }
}
