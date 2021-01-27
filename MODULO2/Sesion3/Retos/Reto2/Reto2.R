library(ggplot2)
library(dplyr)

jugadores <- read.csv("C:/Users/monts/SantanderBEDU/MODULO2/Sesion3/Retos/Reto2/players_stats.csv")

# 1. Generar un histograma de los minuntos totales (MIN), de los jugadores y agregar una linea donde se muestre la media
ggplot(jugadores, aes(MIN))+
  geom_histogram(binwidth = 30, col = "black", fill = "slateblue", bins = 5) +
  ggtitle("Histograma de minutos jugados") + 
  ylab("Frecuencia") + 
  xlab("minutos") + 
  theme_light() + 
  geom_vline(xintercept =  mean(jugadores$MIN), col = "red", lwd = 1.5, lty =2)


# 2. Generar un histograma de edad (Age) y agregar una linea con la media
jugadores <- na.omit(jugadores) 
ggplot(jugadores, aes(Age))+
  geom_histogram(binwidth = 2, col = "black", fill = "slateblue", bins = 5) +
  ggtitle("Histograma de edades") + 
  ylab("Frecuencia") + 
  xlab("Edad") + 
  geom_vline(xintercept =  mean(na.omit(jugadores$Age)), col = "red", lwd = 1.5, lty =2) +
  theme_light() 
  

# 3. Hacer un scatterplot de las variables Weight y Height y observar la correlacion 
# que existe entre ambas variables (1 sola grafica)

p <- jugadores %>% ggplot(aes(Weight, Height)) +
  geom_point()
p
(lmnba <- coef(lm(Height ~ Weight, data = jugadores)))
p + geom_abline(intercept = lmnba[1], slope = lmnba[2], col = "red", lwd = 1.5, lty = 2)

# 4. Utiliza la funcion which.max para saber quien es el jugador mas alto, una 
# vez hecho esto, presenta los resultados en una leyenda que diga "El jugador 
# mas alto es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.

(alto <- which.max(jugadores$Height))
paste("El jugador más alto es:", jugadores$Name[alto],"con una altura de:" , round(jugadores$Height[alto]/100,2), "m")


# 5. Utiliza la funcion which.min para saber quien es el jugador mas bajito, una 
# vez hecho esto, presenta los resultados en una leyenda que diga "El jugador 
# mas bajito es: Name, con una altura de: Height". Las unidades de altura deben ser en metros.

(bajito <- which.min(jugadores$Height))
paste("El jugador más bajito es:", jugadores$Name[bajito],"con una altura de:" ,round(jugadores$Height[bajito]/100,2), "m")


# 6. ¿Cual es la altura promedio?, representa el resultado en una frase que diga:
# "La altura promedio es: ALTURA"

(media<- mean(na.omit(jugadores$Height)))
paste("La altura promedio es:", round(media/100,2),"m")


# 7. Generar un scatterplot donde se representen las Asistencias totales 
# (AST.TOV) vs Puntos (PTS), ademas has un face wrap con la posicion (Pos).

jugadores %>% ggplot( aes(AST.TOV, PTS )) +
  geom_point() + 
  facet_wrap("Pos")
