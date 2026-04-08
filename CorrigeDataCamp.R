rm(list=ls())

archivozip <- "2025-26 Tractament de les dades Gr.A-T (36423)-Tarea Intermediate R(Datacamp)-3281647.zip"
carpeta <- "entregas"

dir.create(carpeta)

unzip(archivozip, exdir = carpeta)