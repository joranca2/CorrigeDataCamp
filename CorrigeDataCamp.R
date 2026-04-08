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


apellidos <- c()
puntos <- c()

for(i in 1:length(ficheros_puntos)){
  
  ruta <- ficheros_puntos[i]
  
  partes <- strsplit(ruta, split = "/", fixed = TRUE)[[1]]
  
  carpeta_alumno <- partes[length(partes)-1]
  
  texto_alumno <- strsplit(carpeta_alumno, split = "_", fixed = TRUE)[[1]][1]
  
  apellido_i <- strsplit(texto_alumno, split = ",", fixed = TRUE)[[1]][1]
  apellidos <- c(apellidos, apellido_i)
  
  contenido_i <- readLines(ruta)
  puntos <- c(puntos, as.numeric(contenido_i[1]))
}

NomFile <- c()

for(i in 1:length(ficheros_puntos)){
  
  ruta <- ficheros_puntos[i]
  
  partes <- strsplit(ruta, split = "/", fixed = TRUE)[[1]]
  
  nombre_i <- partes[length(partes)]
  
  NomFile <- c(NomFile, nombre_i)
}

all(NomFile == "puntos.txt")
unique(NomFile)
length(unique(NomFile))
table(NomFile)

