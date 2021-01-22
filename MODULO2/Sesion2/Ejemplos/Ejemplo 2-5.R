# 2.5 apply, lapply, do.call

# Funcion apply

# La funcion apply regresa un vector, arreglo o lista de valores obtenidos 
# al aplicar una funcion a los margenes de un arreglo o matriz. Por ejemplo

X <- matrix(1:49, ncol = 7)
X
apply(X, 1, mean) # calculo de la media para las filas
apply(X, 2, median) # calculo de la mediana para las columnas


# Funcion lapply

# La funcion lapply se usa de la siguiente manera lapply(X, FUN, ...)
# donde X puede ser un vector o una lista, FUN es una funcion que sera
# aplicada a cada elemento de X y ... representa argumentos opcionales 
# para FUN. lapply regresa una lista de la misma longitud que X, en
# donde cada elemento de la lista es el resultado de aplicar FUN al
# elemento que corresponde de X.

# Vamos a utilizar lapply para leer un conjunto de archivos csv de manera
# consecutiva y rapida, para esto debemos especificar un directorio
# de trabajo y descargar los archivos csv en nuestro directorio, por
# ejemplo, puede crear la carpeta soccer para descargar los datos

#u1011 <- "https://www.football-data.co.uk/mmz4281/1011/SP1.csv"
#u1112 <- "https://www.football-data.co.uk/mmz4281/1112/SP1.csv"
#u1213 <- "https://www.football-data.co.uk/mmz4281/1213/SP1.csv"
#u1314 <- "https://www.football-data.co.uk/mmz4281/1314/SP1.csv"

setwd("C:/Users/monts/SantanderBEDU/MODULO2/Data/Football")

#download.file(url = u1011, destfile = "SP1-1011.csv", mode = "wb")
#download.file(url = u1112, destfile = "SP1-1112.csv", mode = "wb")
#download.file(url = u1213, destfile = "SP1-1213.csv", mode = "wb")
#download.file(url = u1314, destfile = "SP1-1314.csv", mode = "wb")

# podemos visualizar el nombre de los archivos descargados en un vector
# de strings de la siguiente manera

dir()

# podemos leer con una sola instruccion los archivos descargados
# usando la funcion lapply de la siguiente manera

lista <- lapply(dir(), read.csv) # Guardamos los archivos en lista

# los elementos de lista son los archivos csv leidos y se encuentran
# como data frames

library(dplyr)
lista <- lapply(lista, select, Date:FTR) # seleccionamos solo algunas columnas de cada data frame
head(lista[[1]]); head(lista[[2]]); head(lista[[3]]); head(lista[[4]])

# cada uno de los data frames que tenemos en lista, los podemos combinar
# en un unico data frame utilizando las funciones rbind y do.call
# de la siguiente manera

# Funcion do.call

data <- do.call(rbind, lista)
head(data)
dim(data)





