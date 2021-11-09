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

raiz.redondeada(numero = 18, n = 2)

raiz.redondeada(n = 2, numero = 18)

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
  select(...)


#Y muchas cosas mas

respiratorias %>%
  count(provincia_nombre, evento_nombre)

respiratorias.prop <- respiratorias %>%
  count(provincia_nombre, evento_nombre) %>%
  group_by(provincia_nombre) %>%
  mutate(total = sum(n),
         prop = n / total,
         porcentaje = prop * 100)

respiratorias.prop

respiratorias.prop.filtrado <- respiratorias.prop %>%
  filter(prop == max(prop))

respiratorias.prop.filtrado

##### Gráficos: #####
#R base tiene sus gráficos pero no son muy lindos y es dificil manejarlos:

plot(x = respiratorias.prop.filtrado$provincia_nombre, y = respiratorias.prop.filtrado$porcentaje)


#La libreria de gráfios por excelencia en R es ggplot2, ya viene cargada con tidyverse:

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop)) + #Linea base del ggplot, siempre tiene que estar
  geom_col()

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, col = evento_nombre)) +
  geom_col()

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col()

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col() +
  theme_bw()


#Ejercicio: Al gráfico anterior hacer que las barras no esten apiladas (stacked), sino una al lado de la otra (dodged) (buscar en google)

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col(...) +
  theme_bw()

#Ejercicio: al gráfico anterior, cambiarle los nombres de los ejes X e Y y el nombre del titulo de la leyenda (buscar en gogle):

ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col(...) +
  theme_bw() +
  labs(...)

#Ejercicio: Usar colores daltonico-friendly (buscar en google colores viridis):
ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col(...) +
  theme_bw() +
  labs(...) +
  scale_...()

#Ejercicio: Ubicar la leyenda arriba del plot (buscar en las referencias de la funcion theme()):
ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col(...) +
  theme_bw() +
  labs(...) +
  scale_...() +
  theme(legend....)



#Facetas:
ggplot(respiratorias.prop, aes(x = provincia_nombre, y = prop, fill = evento_nombre)) +
  geom_col(position = "dodge", show.legend = FALSE) +
  theme_bw() +
  labs(x = "Provincia", y = "Proporción") +
  scale_fill_viridis_d() +
  facet_wrap(evento_nombre~., ncol = 1)

#Reordenamiento de niveles de variables categoricas:
ggplot(respiratorias.prop, aes(x = fct_reorder(provincia_nombre, prop, max, .desc = TRUE), y = prop, fill = evento_nombre)) +
  geom_col(position = "dodge") +
  theme_bw() +
  labs(x = "Provincia", y = "Proporción", fill = "Evento:") +
  scale_fill_viridis_d() +
  theme(legend.position = "top")

#ggplot puede ser encadenado con pipes y guardado como objeto:

gg.respiratorias <- respiratorias %>%
  count(provincia_nombre, evento_nombre) %>%
  group_by(provincia_nombre) %>%
  mutate(total = sum(n),
         prop = n / total,
         porcentaje = prop * 100) %>%
  ggplot(aes(x = fct_reorder(provincia_nombre, prop, max, .desc = TRUE), y = prop, fill = evento_nombre)) +
  geom_col(position = "dodge") +
  theme_bw() +
  labs(x = "Provincia", y = "Proporción", fill = "Evento:") +
  scale_fill_viridis_d() +
  theme(legend.position = "top")

#Se le pueden seguir agregando cosas:
library(scales)

gg.respiratorias <- gg.respiratorias +
  scale_y_continuous(labels = percent, breaks = seq(0, 1, 0.1)) +
  labs(y = "Porcentaje") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

#Guardar un ggplot:   
ggsave(filename = "Figuras/Mi primer ggplot.png", gg.respiratorias)

#Mas grande:
ggsave(filename = "Figuras/Mi primer gran ggplot.png", gg.respiratorias, width = 12, height = 6)
