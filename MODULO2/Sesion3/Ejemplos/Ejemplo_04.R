# Comenzamos leyendo un fichero, el cual contiene informacion sobre dos grupos 
# de control G1 y G2, a los cuales se les realizq a cada uno una medicion en 3 
# momentos diferentes C1, C2 y C3

# Cargamos las librerias necesarias para la realizacion del ejemplo, ademas del fichero CVS a utilizar

library(ggplot2)
library(dplyr)

data2 <- read.csv("C:/Users/monts/SantanderBEDU/MODULO2/Sesion3/Data/boxp.csv")

# Revisamos el encabezado del fichero y el nombre de sus variables o columnas

head(data2)
names(data2)

# Vamos a realizar un cambio en la variable Mediciones para practicar

data <- mutate(data2, Mediciones = Mediciones*1.23)
head(data)

# Observamos algunos datos estadisticos sobre las variables

summary(data)

# Como estamos ante la presencia de NA´s los eliminamos con complete.cases() y 
# solamente seleccionamos aquellos sin NAs y convertimos en factores la variable
# Categoria y Grupo

bien <- complete.cases(data)
data <- data[bien,]
data <- mutate(data, Categoria = factor(Categoria), Grupo = factor(Grupo))

# Finalmente realizamos el boxplot

ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
  ggtitle("Boxplots") +
  xlab("Categorias") +
  ylab("Mediciones")

# Agregamos el nombre de las etiquetas para los grupos G1 y G2

ggplot(data, aes(x = Categoria, y = Mediciones, fill = Grupo)) + geom_boxplot() +
  scale_fill_discrete(name = "Dos Gps", labels = c("G1", "G2")) + 
  ggtitle("Boxplots") +
  xlab("Categorias") +
  ylab("Mediciones")

