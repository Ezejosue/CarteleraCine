#!/bin/bash

# Obtener la ruta absoluta del directorio raíz del repositorio actual
repo_root=$(git rev-parse --show-toplevel)

# Cambiar al directorio raíz del repositorio
cd "$repo_root"

# Obtener la lista de todas las ramas excepto "main"
for branch in $(git branch | grep -v "main"); do
    # Cambiar a la rama actual
    git checkout $branch

    # Fusionar los cambios de "main" en la rama actual
    git merge main
done