############### Script R inicial #################

#Primero que nada, siempre limpiar el ambiente y recolección de la basura:

rm(list = ls())
gc()


####### Operaciones básicas ######
##### Operaciones matemáticas #####
1 + 5
5^2
5**2
10/2
10/3
(25+3)/15 ** 0.1

NA + 1


##### Objetos #####
#Guardan en memoria RAM a valores, listas, tablas, modelos, etc...
objeto.1 <- 50
objeto.2 <- 100
objeto.3 <- objeto.1 + objeto.2
objeto.3 
objeto.2 <- 500
objeto.3 #Que deberia salir aca?

#Algunos objetos ya estan definidos previamente:
pi
iris
mtcars

##### Funciones: ######
# Hay muchas funciones predefinidas:
sqrt(25)

round(pi, 2)

ceiling(pi)

floor(pi)

log(objeto.20)

vector <- c(4, 15, 2, 22, 1000, 0, 0, 6)

mean(vector)

class(vector)

paste("Asi pego", "muchos textos", "juntos", sep = " ")


# Crear funcion propia. Creo una que calcule la raiz cuadrada y despues redondee con n valores despues de la coma:

raiz.redondeada <- function(numero, n){
  salida <- sqrt(numero)
  round(salida, n)
}

raiz.redondeada(18, 2)


##### Lógica #####
TRUE & TRUE
TRUE & FALSE
TRUE | FALSE
!TRUE
!FALSE

(!TRUE | FALSE) & FALSE | (!TRUE | FALSE) & TRUE


1 > 2
1 == 1
vector <= 6

vector[vector <= 6]


##### Tipo de datos: #####
objeto.4 <- "hola"
objeto.4
class(objeto.4)

objeto.4 <- as.factor(objeto.4)
objeto.4
class(objeto.4)

objeto.4 <- 1L
objeto.4
class(objeto.4)

objeto.4 <-  as.numeric(objeto.4)
objeto.4
class(objeto.4)

objeto.4 <- as.character(objeto.4)
objeto.4
class(objeto.4)

objeto.4 <- as.integer(objeto.4)
objeto.4
class(objeto.4)


as.numeric("hola")



###### Paquetes ######
#Instalacion de paquetes:
install.packages("tidyverse")
#"Activar" un paquete previamente instalado:
library(tidyverse)
# Si no está instalado tira error:
library(paquete.no.instalado)


###### DATA FRAMES o tablas #####

# Data frame desde 0:

individuos <- c("juan carlos", "roberta", "esteban", "lara", "beatriz")
alturas <- c(1.8, 1.65, 1.55, 1.75, 1.9)

tabla.alturas <- data.frame(individuo = individuos,
                            altura = alturas)

tabla.alturas

class(tabla.alturas)

#Lectura desde excels:
library(readxl) #Esta instalado?

respiratorias <- read_xlsx("Datos/respiratorias.xlsx", 1)


#Lectura desde csv:

respiratorias <- read.csv("Datos/respiratorias.csv", stringsAsFactors = TRUE, encoding = "UTF-8")

#### Analisis iniciales de tablas ####

#Dimsension de la tabla:
dim(respiratorias)

#Estructura: tipos de las variables (columnas):

str(respiratorias) #hay cosas feas?


#Resumen rápido:
summary(respiratorias)

# Seleccionar solamente una columna:
respiratorias$provincia_nombre

respiratorias$provincia_nombre == "Chaco"


#### Operaciones básicas sobre tablas: ####
### Filtrado por filas: ###

respiratorias[20:25,] #Por numero de fila

respiratorias.cordoba <- respiratorias[respiratorias$provincia_nombre == "Córdoba",] #Por lógica: respiratorias$provincia_nombre == "Córdoba" es un vector lógico, solo se van a mostrar las filas que cumplan con TRUE

respiratorias.cordoba #que dimension tiene esta tabla?


# Ejercicio: obtener tabla de individuos cuya  provincia_nombre sea "Jujuy" o "Salta": Recordar que "Ó" se escribe como |

respiratorias["REGLA LÓGICA QUE CUMPLA QUE LA COLUMNA 'provincia_nombre' DE LA TABLA 'respiratorias' sea igual a 'Jujuy' o 'Salta'",]


# Ejercicio: obtener tabla de individuos cuyo grupo_edad_id sea 7 y que el registro sea del año 2021: Recordar que "Y" se escribe como &

respiratorias[... ,]

### Filtrado por columnas: ###

respiratorias[, "departamento_nombre"] #que tipo de objeto es?

respiratorias[, c("evento_nombre", "grupo_edad_id")] #que tipo de objeto es?

#Ejercicio: Obtener vector de evento_nombre tal que el grupo edad de los individuos sea 9

respiratorias["FILTRADO POR FILAS" , "FILTRADO POR COLUMNAS"]


### Creación de nuevas columnas: ###
# Queremos crear la columna que sea "provincia_nombre"_"departamento_nombre" (separados por un "_"): Recordar funcion paste():

respiratorias$prov_depto <- paste(respiratorias$provincia_nombre, respiratorias$departamento_nombre, sep = "_")

View(respiratorias)


##### UNIVERSO TIDY ######
# https://www.tidyverse.org/
# Casi una filosofia de trabajo en R
# Conjuno de paquetes muy bien integrados entre sí que facilitan MUCHO las operaciones básicas (y no tan básicas) de R

#Primero lo cargamos:
library(tidyverse)

#Introducimos el pipe %>% :
respiratorias %>%
  summary()

#Filtrado por filas: funcion filter()

respiratorias %>%
  filter(provincia_nombre == "Córdoba")

#Filtrado por columnas: funcion select()

respiratorias %>%
  select(evento_nombre, grupo_edad_id)

#Filtrado por filas y columnas: encadenar con pipes

respiratorias %>%
  filter(provincia_nombre == "Córdoba") %>%
  select(evento_nombre, grupo_edad_id)

#Crear nuevas variables: funcion mutate()

respiratorias %>%
  mutate(prov_depto = paste(provincia_nombre, departamento_nombre, sep = "_"))

#Repetir los ejercicios de arriba pero usando tidyverse:
respiratorias %>%
  filter(... | ...) %>%
  select()


#Y muchas cosas mas

respiratorias %>%
  count(provincia_nombre, evento_nombre)

respiratorias %>%
  count(provincia_nombre, evento_nombre) %>%
  group_by(provincia_nombre) %>%
  mutate(total = sum(n),
         prop = n / total,
         porcentaje = prop * 100) %>%
  filter(prop == max(prop))


##### Gráficos: #####







