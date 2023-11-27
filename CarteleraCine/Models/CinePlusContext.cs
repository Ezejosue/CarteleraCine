using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace CarteleraCine.Models;

public partial class CinePlusContext : DbContext
{
    public CinePlusContext()
    {
    }

    public CinePlusContext(DbContextOptions<CinePlusContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Calificacione> Calificaciones { get; set; }

    public virtual DbSet<Funcione> Funciones { get; set; }

    public virtual DbSet<Pelicula> Peliculas { get; set; }

    public virtual DbSet<Sala> Salas { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Calificacione>(entity =>
        {
            entity.HasKey(e => e.CalificacionId).HasName("PK__Califica__4CF54ABE7680FA3C");

            entity.Property(e => e.CalificacionId).HasColumnName("CalificacionID");
            entity.Property(e => e.FechaCalificacion)
                .HasDefaultValueSql("(getdate())")
                .HasColumnType("datetime");
            entity.Property(e => e.PeliculaId).HasColumnName("PeliculaID");

            entity.HasOne(d => d.Pelicula).WithMany(p => p.Calificaciones)
                .HasForeignKey(d => d.PeliculaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Calificac__Pelic__286302EC");
        });

        modelBuilder.Entity<Funcione>(entity =>
        {
            entity.HasKey(e => e.FuncionId).HasName("PK__Funcione__F22456E418DB42BF");

            entity.Property(e => e.FuncionId).HasColumnName("FuncionID");
            entity.Property(e => e.Horario).HasColumnType("datetime");
            entity.Property(e => e.PeliculaId).HasColumnName("PeliculaID");
            entity.Property(e => e.SalaId).HasColumnName("SalaID");

            entity.HasOne(d => d.Pelicula).WithMany(p => p.Funciones)
                .HasForeignKey(d => d.PeliculaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Funciones__Pelic__2D27B809");

            entity.HasOne(d => d.Sala).WithMany(p => p.Funciones)
                .HasForeignKey(d => d.SalaId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Funciones__SalaI__2E1BDC42");
        });

        modelBuilder.Entity<Pelicula>(entity =>
        {
            entity.HasKey(e => e.PeliculaId).HasName("PK__Pelicula__5AC6F32C43F54944");

            entity.Property(e => e.PeliculaId).HasColumnName("PeliculaID");
            entity.Property(e => e.Clasificacion).HasMaxLength(5);
            entity.Property(e => e.Director).HasMaxLength(255);
            entity.Property(e => e.Genero).HasMaxLength(50);
            entity.Property(e => e.TipoButacas).HasMaxLength(50);
            entity.Property(e => e.Titulo).HasMaxLength(255);
        });

        modelBuilder.Entity<Sala>(entity =>
        {
            entity.HasKey(e => e.SalaId).HasName("PK__Salas__0428485AD2EEFE7A");

            entity.Property(e => e.SalaId).HasColumnName("SalaID");
            entity.Property(e => e.Nombre).HasMaxLength(100);
            entity.Property(e => e.TipoButacas).HasMaxLength(50);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
