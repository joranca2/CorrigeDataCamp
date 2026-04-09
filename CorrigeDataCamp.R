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
  
  partes_carpeta <- strsplit(carpeta_alumno, split = "_", fixed = TRUE)[[1]]
  
  texto_alumno <- partes_carpeta[1]
  
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


apellidos_justificante <- c()

for(i in 1:length(ficheros_justificante)){
  
  ruta <- ficheros_justificante[i]
  
  partes <- strsplit(ruta, split = "/", fixed = TRUE)[[1]]
  
  carpeta_alumno <- partes[length(partes)-1]
  
  texto_alumno <- strsplit(carpeta_alumno, split = "_", fixed = TRUE)[[1]][1]
  
  apellido_i <- strsplit(texto_alumno, split = ",", fixed = TRUE)[[1]][1]
  
  apellidos_justificante <- c(apellidos_justificante, apellido_i)
}

TieneJustificante <- apellidos %in% apellidos_justificante

all(TieneJustificante)
apellidos[!TieneJustificante]

#Convierto puntos a cadena de texto:

Puntos <- as.character(puntos)

#Creamos el dataframe con sus respectivas columnnas:

evaluados_df <- data.frame(apellidos, puntos, NomFile, Puntos)

evaluados_df <- evaluados_df[order(evaluados_df$apellidos), ]

evaluados_df

#La carga y creacion de ficheros:

install.packages("readxl")
library(readxl)

alumnos_df <- read_excel("AlumnosTD25_26.xlsx")

alumnos_df$apellidos <- alumnos_df[["Apellido(s)"]] #Uno por apellidos porque no se como 
                                                     #hacer con ID, aunque si hay apellidos iguales
                                                      #y tal puede fallar.

AlumnosNotas <- merge(alumnos_df, evaluados_df, by = "apellidos", all.x = TRUE)

install.packages("openxlsx")
library(openxlsx)

write.xlsx(evaluados_df, "NotasRIntermedio.xlsx", rowNames = FALSE)
write.xlsx(AlumnosNotas, "AlumnosNotas.xlsx", rowNames = FALSE)

writeLines("https://github.com/joranca2/CorrigeDataCamp.git", "EnlaceRepo.txt")

