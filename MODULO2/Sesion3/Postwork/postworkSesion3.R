###
#   Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el
#   numero de goles que anotan en un partido el equipo de casa o el equipo visitante.
###
setwd("C:/Users/monts/SantanderBEDU/MODULO2/Sesion3/Postwork") 
data <- read.csv("dataSesion2.csv")
data
# 1. Con el ultimo data frame obtenido en el postwork de la sesion 2,
# elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
library(ggplot2)
attach(data)

# * La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

casa <- prop.table(table(FTHG))

# * La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

visita <- prop.table(table(FTAG))

# * La probabilidad (conjunta) de que el equipo que juega en casa anote x goles 
#   y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

goles <- prop.table(table(FTHG,FTAG))
dat <- matrix(rnorm(100, 3, 1), ncol=10)
class(dat)

# 2. Realiza lo siguiente:

# * Un grafico de barras para las probabilidades marginales estimadas del numero
#   de goles que anota el equipo de casa
barplot(casa, xlab = "Goles amotados por el equipo de casa", ylab = "Probabilidad")
# * Un grafico de barras para las probabilidades marginales estimadas del numero
#   de goles que anota el equipo visitante.
barplot(visita, xlab = "Goles amotados por el equipo visitante", ylab = "Probabilidad")
# * Un HeatMap para las probabilidades conjuntas estimadas de los numeros de 
#   goles que anotan el equipo de casa y el equipo visitante en un partido.
goles <- as.data.frame(goles)
p <- ggplot(goles, aes(FTHG, FTAG)) +
        geom_tile(aes(fill = Freq)) +
        geom_text(aes(label = round(Freq, 3))) + 
        scale_fill_continuous(low = "violetred", high = "aquamarine")
p <- p + labs(x  = "Goles en casa")
p <- p + labs(y = "Goles de visita")
p <- p + labs(fill = "Probabilidad")
p
detach(data)
