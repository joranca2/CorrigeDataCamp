rm(list=ls())

archivozip <- "2025-26 Tractament de les dades Gr.A-T (36423)-Tarea Intermediate R(Datacamp)-3281647.zip"
carpeta <- "entregas"

dir.create(carpeta)

unzip(archivozip, exdir = carpeta)


ficheros_puntos <- list.files(path = carpeta, 
                              pattern = "puntos", 
                              recursive = TRUE, 
                              full.names = TRUE)

ficheros_puntos

ficheros_justificante <- list.files(path = carpeta,
                                    pattern = "certificate",
                                    recursive = TRUE,
                                    full.names = TRUE)

ficheros_justificante
