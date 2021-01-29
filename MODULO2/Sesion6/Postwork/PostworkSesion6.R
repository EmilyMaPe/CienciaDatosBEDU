###
#   Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:
###
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion6/Postwork")
datos <- read.csv("match.data.csv")
mutate(datos, date = as.Date(date, "%Y-%m-%d"))
head(datos)
library(dplyr)
attach(datos)
# 1. Agrega una nueva columna sumagoles que contenga la suma de goles por partido.


n = dim(datos)[1]
sumagoles <- rep(0, n)
for (i in 1:n) {
  sumagoles[i] <-  datos$home.score[i] + datos$away.score[i]
}
datos <- cbind(datos, sumagoles)


# 2. Obtén el promedio por mes de la suma de goles.


datos <- mutate(datos, Ym = format(as.Date(date), "%Y-%m"))
goles <- datos %>% group_by(Ym) %>% summarise(goles = mean(sumagoles))
goles

# 3. Crea la serie de tiempo del promedio por mes de la suma de goles hasta 
#    diciembre de 2019.

tsGoles <- ts(goles$goles, start = c(2010,8), end = c(2019, 12), frequency = 12)
tsGoles

# 4. Grafica la serie de tiempo.

ts.plot(tsGoles)
