# EJEMPLO 5. Instalar paquetes y cargarlos.

# Objetivo
# Instalar paquetes
# Cargar paquetes

# Requisitos
# R y RStudio
# Prework

# Desarrollo
# En este ejemplo se te guiara para poder realizar la instalacion y carga de
# paquetes que son requeridos para realizar analisis, graficas, o para extraer
# informacion con diversas funciones. Esto es util ya que agrega funcionalidades
# a R, ya sea para graficar o generar analisis con diversas tecnicas.

# Se instalan de la siguiente manera

#install.packages("ggplot2") #siempre lleva  comillas

# Una vez que se instala, se debe de cargar

library(ggplot2) # Se omite el uso de las comillas

# Otro ejemplo

#install.packages("dplyr")
library(dplyr)

# Algo util es revisar la version que se tiene de R, ya que en ocasiones no se 
# instalan ciertos paquetes por la incompatibilidad de R, el siguiente comando
# nos indicara la versin oque estamos trabajando.

version

# Tambien se puede realizar esta accion en la pestaña de Packages, intentalo.
